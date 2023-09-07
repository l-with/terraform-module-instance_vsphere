variable "cloud_provider" {
  description = "the cloud provider to deploy to"
  type        = string
  validation {
    condition     = contains(["digitalocean", "hetzner", "vsphere"], var.cloud_provider)
    error_message = "Supported values (in order of descending detail) are digitalocean, hetzner, vsphere."
  }
}

variable "hetzner_token" {
  description = "the Hetzner Cloud API Token (used to query the server types)"
  type        = string
  default     = null
  sensitive   = true
}

variable "hetzner_preferred_country_locations" {
  description = "the location that should be preferred for the countries with more than one location"
  type        = list(map(string))
  default = [{
    "DE" : "fsn1",
    "US" : "hil",
  }]
}

variable "digitalocean_token" {
  description = "the Digital Ocean API token (used to query the server types)"
  type        = string
  default     = null
  sensitive   = true
}

variable "vsphere" {
  description = "the vsphere names of the datacenter, datastore, cluster and network and optional the name of tag_category and disk and the folder"
  type = object({
    datacenter_name   = string
    datastore_name    = string
    cluster_name      = string
    network_name      = string
    folder            = optional(string, "/")
    disk_name         = optional(string, "disk0")
    tag_category_name = optional(string, null)
  })
  default = null
}

variable "digitalocean_preferred_country_region_slugs" {
  description = "the region slug that should be preferred for the countries with more than one slug"
  type        = list(map(string))
  default = [{
    "US" : "nyc3",
  }]
}

variable "digitalocean_region_slug_pattern_country_code_mapping" {
  type = list(map(string))
  default = [{
    "nyc1" : "US",
    "sgp1" : "SG",
    "lon1" : "GB",
    "nyc3" : "US",
    "ams3" : "NL",
    "fra1" : "DE",
    "tor1" : "CA",
    "sfo2" : "US",
    "blr1" : "IN",
    "sfo3" : "US",
    "syd1" : "AU",
  }]
}

variable "instance" {
  description = "if the instance should be created"
  type        = bool
  default     = true
}

variable "decoupled_ip" {
  description = "if the instance should be created with a decoupled ip"
  type        = bool
  default     = false
}

variable "country" {
  description = "the [ISO 3166 country code](https://www.iso.org/obp/ui/#search) (Alpha-2) where the instance should be created"
  default     = null
}

variable "type" {
  description = "the type of the instance (will be transformed matching the possiblities of the cloud_provider)"
  type = object({
    vcpus : number,
    ram : number,
    disk : number,
  })
  default = null
}

variable "name" {
  description = "the name of the instance"
  type        = string
}

variable "image" {
  description = "the image the instance should be created from"
  type        = string
}

variable "user_data" {
  description = "the cloud-Init user data to use during instance creation"
  type        = string
  default     = null
  sensitive   = true
}

variable "assign_tags" {
  description = "the tags to assign to the instance"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "the tags to create and assign to the instance"
  type        = list(string)
  default     = []
}

variable "ssh_keys" {
  description = "the SSH key IDs or names which should be injected into the server at creation time"
  type        = list(string)
  default     = []
}
