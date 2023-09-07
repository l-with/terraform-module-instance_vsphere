terraform {
  required_version = ">= 1.3"
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.42"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.22.2"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.4.2"
    }
  }
}
