# Terraform Modul instance_vsphere

Terraform module to provide instance on 

- [digitalocean](https://registry.terraform.io/providers/digitalocean/digitalocean/latest) 
- [hetzner](https://registry.terraform.io/providers/hetznercloud/hcloud/latest)
- [vsphere](https://registry.terraform.io/providers/hashicorp/vsphere/latest)

## Motivation

The motivation is to make switching between platforms as easy as possible.

## terraform

<!-- BEGIN_TF_DOCS -->
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.22.2 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | ~> 1.42 |
| <a name="requirement_vsphere"></a> [vsphere](#requirement\_vsphere) | ~> 2.4.2 |

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.22.2 |
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | ~> 1.42 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | ~> 2.4.2 |

#### Modules

No modules.

#### Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.instance](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_reserved_ip.instance](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/reserved_ip) | resource |
| [digitalocean_reserved_ip_assignment.instance](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/reserved_ip_assignment) | resource |
| [digitalocean_tag.instance](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/tag) | resource |
| [hcloud_primary_ip.instance](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/primary_ip) | resource |
| [hcloud_server.instance](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_server.instance_with_primary_ip](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [vsphere_tag.instance](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/tag) | resource |
| [vsphere_virtual_machine.instance](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine) | resource |
| [http_http.digitalocean_images](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.digitalocean_regions](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.digitalocean_sizes](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.hetzner_datacenters](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.hetzner_images](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.hetzner_locations](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.hetzner_server_types](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [vsphere_compute_cluster.instance](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/compute_cluster) | data source |
| [vsphere_datacenter.instance](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datacenter) | data source |
| [vsphere_datastore.instance](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore) | data source |
| [vsphere_network.instance](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/network) | data source |
| [vsphere_tag_category.instance](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/tag_category) | data source |
| [vsphere_virtual_machine.instance](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/virtual_machine) | data source |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_tags"></a> [assign\_tags](#input\_assign\_tags) | the tags to assign to the instance | `list(any)` | `[]` | no |
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider) | the cloud provider to deploy to | `string` | n/a | yes |
| <a name="input_country"></a> [country](#input\_country) | the [ISO 3166 country code](https://www.iso.org/obp/ui/#search) (Alpha-2) where the instance should be created | `any` | `null` | no |
| <a name="input_decoupled_ip"></a> [decoupled\_ip](#input\_decoupled\_ip) | if the instance should be created with a decoupled ip | `bool` | `false` | no |
| <a name="input_digitalocean_preferred_country_region_slugs"></a> [digitalocean\_preferred\_country\_region\_slugs](#input\_digitalocean\_preferred\_country\_region\_slugs) | the region slug that should be preferred for the countries with more than one slug | `list(map(string))` | <pre>[<br>  {<br>    "US": "nyc3"<br>  }<br>]</pre> | no |
| <a name="input_digitalocean_region_slug_pattern_country_code_mapping"></a> [digitalocean\_region\_slug\_pattern\_country\_code\_mapping](#input\_digitalocean\_region\_slug\_pattern\_country\_code\_mapping) | n/a | `list(map(string))` | <pre>[<br>  {<br>    "ams3": "NL",<br>    "blr1": "IN",<br>    "fra1": "DE",<br>    "lon1": "GB",<br>    "nyc1": "US",<br>    "nyc3": "US",<br>    "sfo2": "US",<br>    "sfo3": "US",<br>    "sgp1": "SG",<br>    "syd1": "AU",<br>    "tor1": "CA"<br>  }<br>]</pre> | no |
| <a name="input_digitalocean_token"></a> [digitalocean\_token](#input\_digitalocean\_token) | the Digital Ocean API token (used to query the server types) | `string` | `null` | no |
| <a name="input_hetzner_preferred_country_locations"></a> [hetzner\_preferred\_country\_locations](#input\_hetzner\_preferred\_country\_locations) | the location that should be preferred for the countries with more than one location | `list(map(string))` | <pre>[<br>  {<br>    "DE": "fsn1",<br>    "US": "hil"<br>  }<br>]</pre> | no |
| <a name="input_hetzner_token"></a> [hetzner\_token](#input\_hetzner\_token) | the Hetzner Cloud API Token (used to query the server types) | `string` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | the image the instance should be created from | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | if the instance should be created | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | the name of the instance | `string` | n/a | yes |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | the SSH key IDs or names which should be injected into the server at creation time | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | the tags to create and assign to the instance | `list(string)` | `[]` | no |
| <a name="input_type"></a> [type](#input\_type) | the type of the instance (will be transformed matching the possiblities of the cloud\_provider) | <pre>object({<br>    vcpus : number,<br>    ram : number,<br>    disk : number,<br>  })</pre> | `null` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | the cloud-Init user data to use during instance creation | `string` | `null` | no |
| <a name="input_vsphere"></a> [vsphere](#input\_vsphere) | the vsphere names of the datacenter, datastore, cluster and network and optional the name of tag\_category and disk and the folder | <pre>object({<br>    datacenter_name   = string<br>    datastore_name    = string<br>    cluster_name      = string<br>    network_name      = string<br>    folder            = optional(string, "/")<br>    disk_name         = optional(string, "disk0")<br>    tag_category_name = optional(string, null)<br>  })</pre> | `null` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_digitalocean_droplet_images"></a> [digitalocean\_droplet\_images](#output\_digitalocean\_droplet\_images) | the list of the digitalocean droplet images |
| <a name="output_digitalocean_droplet_size"></a> [digitalocean\_droplet\_size](#output\_digitalocean\_droplet\_size) | the selected digitalocean droplet size |
| <a name="output_digitalocean_droplet_sizes"></a> [digitalocean\_droplet\_sizes](#output\_digitalocean\_droplet\_sizes) | the list of the digitalocean droplet sizes |
| <a name="output_digitalocean_region_slug"></a> [digitalocean\_region\_slug](#output\_digitalocean\_region\_slug) | the name of the selected digitalocean region |
| <a name="output_digitalocean_regions"></a> [digitalocean\_regions](#output\_digitalocean\_regions) | the list of the digitalocean regions |
| <a name="output_hetzner_datacenter_name"></a> [hetzner\_datacenter\_name](#output\_hetzner\_datacenter\_name) | the name of the selected hetzner datacenter |
| <a name="output_hetzner_datacenters"></a> [hetzner\_datacenters](#output\_hetzner\_datacenters) | the list of the hetzner datacenters |
| <a name="output_hetzner_location_name"></a> [hetzner\_location\_name](#output\_hetzner\_location\_name) | the name of the selected hetzner location |
| <a name="output_hetzner_locations"></a> [hetzner\_locations](#output\_hetzner\_locations) | the list of the hetzner locations |
| <a name="output_hetzner_server_images"></a> [hetzner\_server\_images](#output\_hetzner\_server\_images) | the list of the hetzner server images |
| <a name="output_hetzner_server_type"></a> [hetzner\_server\_type](#output\_hetzner\_server\_type) | the selected hetzner server type |
| <a name="output_hetzner_server_types"></a> [hetzner\_server\_types](#output\_hetzner\_server\_types) | the list of the hetzner server types |
| <a name="output_instance"></a> [instance](#output\_instance) | the instance resource |
| <a name="output_instance_decoupled_ip_address"></a> [instance\_decoupled\_ip\_address](#output\_instance\_decoupled\_ip\_address) | the decoupled ip address of the instance |
| <a name="output_instance_ip_address"></a> [instance\_ip\_address](#output\_instance\_ip\_address) | the ip address of the instance |
<!-- END_TF_DOCS -->
