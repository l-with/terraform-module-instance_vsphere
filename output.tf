output "hetzner_server_types" {
  description = "the list of the hetzner server types"
  value       = local.hetzner_server_types_without_deprecation
}

output "hetzner_locations" {
  description = "the list of the hetzner locations"
  value       = local.hetzner_locations
}

output "hetzner_datacenters" {
  description = "the list of the hetzner datacenters"
  value       = local.hetzner_datacenters
}

output "hetzner_server_images" {
  description = "the list of the hetzner server images"
  value       = local.hetzner_server_images_filtered
}

output "hetzner_server_type" {
  description = "the selected hetzner server type"
  value       = local.hetzner_server_type
}

output "hetzner_location_name" {
  description = "the name of the selected hetzner location"
  value       = local.hetzner_location_name
}

output "hetzner_datacenter_name" {
  description = "the name of the selected hetzner datacenter"
  value       = local.hetzner_datacenter_name
}

output "instance" {
  description = "the instance resource"
  value = (
    !var.instance ? null : var.decoupled_ip ? (
      local.hetzner ? hcloud_server.instance_with_primary_ip[0] : (
        local.digitalocean ? digitalocean_droplet.instance[0] : null
      )) : (
      local.hetzner ? hcloud_server.instance[0] : (
        local.digitalocean ? digitalocean_droplet.instance[0] : null
      )
    )
  )
}

output "instance_ip_address" {
  description = "the ip address of the instance"
  value = (
    (var.instance && !var.decoupled_ip) ? (
      local.hetzner ? hcloud_server.instance[0].ipv4_address : (
        local.digitalocean ? digitalocean_droplet.instance[0].ipv4_address : null
      )
    ) : null
  )
}

output "instance_decoupled_ip_address" {
  description = "the decoupled ip address of the instance"
  value = (
    (var.instance && var.decoupled_ip) ? (
      local.hetzner ? hcloud_primary_ip.instance[0].ip_address : (
        local.digitalocean ? digitalocean_droplet.instance[0].ipv4_address : null
      )
    ) : null
  )
}

output "digitalocean_droplet_sizes" {
  description = "the list of the digitalocean droplet sizes"
  value       = local.digitalocean_droplet_sizes
}

output "digitalocean_regions" {
  description = "the list of the digitalocean regions"
  value       = local.digitalocean_regions
}

output "digitalocean_droplet_images" {
  description = "the list of the digitalocean droplet images"
  value       = local.digitalocean_droplet_images_filtered
}

output "digitalocean_region_slug" {
  description = "the name of the selected digitalocean region"
  value       = local.digitalocean_region_slug
}

output "digitalocean_droplet_size" {
  description = "the selected digitalocean droplet size"
  value       = local.digitalocean_droplet_size
}