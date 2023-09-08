terraform {
  required_version = ">= 1.3"
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.4.2"
    }
  }
}
