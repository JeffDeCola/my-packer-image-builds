variable "account_file" {
  type    = string
  default = ""
}

variable "disk_size" {
  type    = string
  default = "30"
}

variable "disk_type" {
  type    = string
  default = "pd-standard"
}

variable "image_description" {
  type    = string
  default = "GCE custom machine image for Jeffs Repo my-packer-image-builds"
}

variable "image_name" {
  type    = string
  default = "gce-ubuntu-2204"
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "prefix" {
  type    = string
  default = "jeffs"
}

variable "project_id" {
  type    = string
  default = ""
}

variable "source_image" {
  type    = string
  default = "ubuntu-2204-jammy-v20230214"
}

variable "source_image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "user_home" {
  type    = string
  default = "${env("HOME")}"
}

variable "zone" {
  type    = string
  default = "us-east1-b"
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.
locals {
  postfix = "${legacy_isotime("20060102")}"
}

source "googlecompute" "example" {
  account_file        = "${var.account_file}"
  communicator        = "ssh"
  disk_size           = "${var.disk_size}"
  disk_type           = "${var.disk_type}"
  image_description   = "${var.image_description}"
  image_name          = "${var.prefix}-${var.image_name}-image"
  instance_name       = "packer-${var.image_name}-instance"
  machine_type        = "${var.machine_type}"
  project_id          = "${var.project_id}"
  source_image        = "${var.source_image}"
  source_image_family = "${var.source_image_family}"
  ssh_timeout         = "5m"
  ssh_username        = "${var.ssh_username}"
  use_internal_ip     = false
  zone                = "${var.zone}"       # Where the image will be built.
}

build {
  sources = [
    "source.googlecompute.example"
  ]

  provisioner "shell" {
    inline       = ["echo THIS IS NEEDED!!! Only doing this to add a pause before file transfers"]
    pause_after  = "3s"
    pause_before = "3s"
  }

  provisioner "file" {
    destination = "/tmp/welcome.txt"
    source      = "./install-files/welcome.txt"
  }

  provisioner "file" {
    destination = "/tmp/settings.json"
    source      = "./install-files/settings.json"
  }

  provisioner "file" {
    destination = "/tmp/gce-github-vm.pub"
    source      = "${var.user_home}/.ssh/gce-github-vm.pub"
  }

  provisioner "file" {
    destination = "/tmp/gce-github-vm"
    source      = "${var.user_home}/.ssh/gce-github-vm"
  }

  provisioner "file" {
    destination = "/tmp/gce-universal-key-for-all-vms.pub"
    source      = "${var.user_home}/.ssh/gce-universal-key-for-all-vms.pub"
  }

  provisioner "file" {
    destination = "/tmp/gce-universal-key-for-all-vms"
    source      = "${var.user_home}/.ssh/gce-universal-key-for-all-vms"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E {{ .Path }}"
    pause_before    = "4s"
    scripts         = [
      "./install-scripts/update-upgrade-system.sh",
      "./install-scripts/add-user-jeff.sh",
      "./install-scripts/edit-bashrc-for-jeff.sh",
      "./install-scripts/move-welcome-file-to-jeff.sh",
      "./install-scripts/add-gce-universal-ssh-keys-to-jeff.sh",
      "./install-scripts/add-github-ssh-keys-to-root.sh",
      "./install-scripts/add-github-ssh-keys-to-jeff.sh",
      "./install-scripts/install-packages.sh"
      # "./install-scripts/install-docker.sh",
      # "./install-scripts/install-go-and-config-for-root.sh",
      # "./install-scripts/config-go-for-jeff.sh",
      # "./install-scripts/pull-private-repos-for-jeff.sh",
      # "./install-scripts/add-vscode-settings-json-file.sh",
      # "./install-scripts/install-protocol-buffers-for-go.sh"
    ]
  }

}
