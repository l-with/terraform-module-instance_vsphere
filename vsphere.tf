locals {
  vsphere = (var.cloud_provider == "vsphere")
}

data "vsphere_datacenter" "instance" {
  count = var.instance && local.vsphere ? 1 : 0

  name = var.vsphere.datacenter_name
}

data "vsphere_datastore" "instance" {
  count = var.instance && local.vsphere ? 1 : 0

  name          = var.vsphere.datastore_name
  datacenter_id = data.vsphere_datacenter.instance[0].id
}

data "vsphere_compute_cluster" "instance" {
  count = var.instance && local.vsphere ? 1 : 0

  name          = var.vsphere.cluster_name
  datacenter_id = data.vsphere_datacenter.instance[0].id
}

data "vsphere_network" "instance" {
  count = var.instance && local.vsphere ? 1 : 0

  name          = var.vsphere.network_name
  datacenter_id = data.vsphere_datacenter.instance[0].id
}

data "vsphere_virtual_machine" "instance" {
  count = var.instance && local.vsphere ? 1 : 0

  name          = var.image
  datacenter_id = data.vsphere_datacenter.instance[0].id
}

data "vsphere_tag_category" "instance" {
  count = var.instance && local.vsphere ? 1 : 0

  name = var.vsphere.tag_category_name
}

resource "vsphere_tag" "instance" {
  count = var.instance && local.vsphere ? length(var.tags) : 0

  category_id = data.vsphere_tag_category.instance[0].id
  name        = var.tags[count.index]
}

resource "vsphere_virtual_machine" "instance" {
  count = var.instance && local.vsphere ? 1 : 0

  name             = var.name
  resource_pool_id = data.vsphere_compute_cluster.instance[0].resource_pool_id
  datastore_id     = data.vsphere_datastore.instance[0].id
  guest_id         = data.vsphere_virtual_machine.instance[0].guest_id
  folder           = var.vsphere.folder
  num_cpus         = var.type.vcpus
  memory           = 1024 * var.type.ram
  tags             = vsphere_tag.instance[*].id
  network_interface {
    network_id = data.vsphere_network.instance[0].id
  }
  disk {
    label            = var.vsphere.disk_name
    size             = var.type.disk
    eagerly_scrub    = data.vsphere_virtual_machine.instance[0].disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.instance[0].disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.instance[0].id
  }
  cdrom {
    client_device = true
  }
  vapp {
    properties = {
      hostname  = var.name
      user-data = var.user_data
    }
  }
}
