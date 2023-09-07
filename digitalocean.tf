locals {
  digitalocean = (var.cloud_provider == "digitalocean")
}

data "http" "digitalocean_sizes" {
  count = local.digitalocean ? 1 : 0
  url   = "https://api.digitalocean.com/v2/sizes?per_page=200"
  request_headers = {
    Authorization = "Bearer ${var.digitalocean_token}"
  }
}

data "http" "digitalocean_regions" {
  count = local.digitalocean ? 1 : 0
  url   = "https://api.digitalocean.com/v2/regions"
  request_headers = {
    Authorization = "Bearer ${var.digitalocean_token}"
  }
}

data "http" "digitalocean_images" {
  count = local.digitalocean ? 1 : 0
  url   = "https://api.digitalocean.com/v2/images?per_page=200"
  request_headers = {
    Authorization = "Bearer ${var.digitalocean_token}"
  }
}

locals {
  digitalocean_droplet_sizes  = !local.digitalocean ? [] : jsondecode(data.http.digitalocean_sizes[0].response_body).sizes
  digitalocean_regions_pure   = !local.digitalocean ? [] : jsondecode(data.http.digitalocean_regions[0].response_body).regions
  digitalocean_droplet_images = !local.digitalocean ? [] : jsondecode(data.http.digitalocean_images[0].response_body).images

  digitalocean_droplet_sizes_filtered = [
    for size in local.digitalocean_droplet_sizes :
    size if size.vcpus >= var.type.vcpus && size.memory >= var.type.ram && size.disk >= var.type.disk
  ]
  digital_ocean_region_slug_pattern_country_code_mapping = merge(var.digitalocean_region_slug_pattern_country_code_mapping...)
  digitalocean_regions = [
    for region in local.digitalocean_regions_pure :
    merge(region, {
      country = lookup(local.digital_ocean_region_slug_pattern_country_code_mapping, region.slug, null)
    }) if region.available
  ]
  digitalocean_droplet_images_filtered = [
    for droplet_image in local.digitalocean_droplet_images : {
      description  = droplet_image.description,
      name         = droplet_image.name,
      slug         = droplet_image.slug,
      distribution = droplet_image.distribution,
    } if droplet_image.type != "snapshot" && droplet_image.status == "available"
  ]
  digitalocean_country_regions = [
    for region in local.digitalocean_regions :
    region if region.country == var.country
  ]
  merged_digitalocean_preferred_country_slugs = merge(var.digitalocean_preferred_country_region_slugs...)
  digitalocean_country_region = (!local.digitalocean ? [] :
    length(local.digitalocean_country_regions) == 1 ? local.digitalocean_country_regions : [
      for region in local.digitalocean_country_regions :
      region if region.slug == lookup(local.merged_digitalocean_preferred_country_slugs, var.country, region.slug)
    ]
  )
  digitalocean_region_slug = (
    length(local.digitalocean_country_region) == 0 ? null : (
      length(local.digitalocean_country_region) == 1 ? local.digitalocean_country_region[0].slug :
      null
    )
  )
  digitalocean_droplet_sizes_filtered_by_region = [
    for size in local.digitalocean_droplet_sizes_filtered :
    size if contains(size.regions, local.digitalocean_region_slug)
  ]
  digitalocean_sorted_price_hourly_slug = sort([
    for size in local.digitalocean_droplet_sizes_filtered_by_region :
    "${size.price_hourly}#${size.slug}"
  ])
  digitalocean_droplet_size = length(local.digitalocean_sorted_price_hourly_slug) == 0 ? null : split("#", local.digitalocean_sorted_price_hourly_slug[0])[1]
}

resource "digitalocean_reserved_ip" "instance" {
  count = var.instance && var.decoupled_ip && local.digitalocean ? 1 : 0

  region = local.digitalocean_region_slug
}

resource "digitalocean_reserved_ip_assignment" "instance" {
  count = var.instance && var.decoupled_ip && local.digitalocean ? 1 : 0

  droplet_id = digitalocean_droplet.instance[0].id
  ip_address = digitalocean_reserved_ip.instance[0].ip_address
}

resource "digitalocean_tag" "instance" {
  count = var.instance && local.digitalocean ? length(var.tags) : 0

  name = var.tags[count.index]
}

resource "digitalocean_droplet" "instance" {
  count = var.instance && local.digitalocean ? 1 : 0

  name      = var.name
  image     = var.image
  size      = local.digitalocean_droplet_size
  region    = local.digitalocean_region_slug
  ssh_keys  = var.ssh_keys
  user_data = var.user_data
  tags = concat(
    var.assign_tags,
    digitalocean_tag.instance[*].id
  )
}
