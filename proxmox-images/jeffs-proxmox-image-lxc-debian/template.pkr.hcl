# my-packer-image-builds jeffs-proxmox-image-lxc-debian

# ============================================================================
# PLUGINS
# ============================================================================

packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

# ============================================================================
# VARIABLES
# ============================================================================

# ----------------------------------------
# Proxmox Connection

variable "proxmox_url" {
  type    = string
  default = "https://192.168.20.135:8006/api2/json"
}
variable "proxmox_token_id" { # FROM COMMAND
  type    = string
  default = ""
}
variable "proxmox_token_secret" { # FROM COMMAND
  type      = string
  default   = ""
  sensitive = true
}
variable "proxmox_node" {
  type    = string
  default = "r730"
}

# ----------------------------------------
# Container Identity

variable "vm_id" {
  type    = number
  default = 600
}
variable "vm_name_prefix" {
  type    = string
  default = "jeffs"
}
variable "image_name" {  # FROM COMMAND
  type    = string
  default = ""
}
variable "image_description" {
  type    = string
  default = "Proxmox custom machine image for Jeffs Repo my-packer-image-builds"
}

# ----------------------------------------
# VM Hardware

variable "cores" {
  type    = number
  default = 2
}
variable "memory" {
  type    = number
  default = 2048
}
variable "disk_size" {
  type    = string
  default = "30G"
}
variable "storage_pool" {
  type    = string
  default = "SSD-Fast"
}

# ----------------------------------------
# Network Interface

variable "network_ip" {
  type    = string
  default = "192.168.20.251/24"
}
variable "network_gw" {
  type    = string
  default = "192.168.20.1"
}

# ----------------------------------------
# SSH / Communicator

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "ssh_host" {
  type    = string
  default = "192.168.20.251"
}

variable "ssh_private_key_file" {
  type    = string
  default = ".ssh/proxmox_universal"
}

variable "ssh_public_key_file" {
  type    = string
  default = ".ssh/proxmox_universal.pub"
}

# ----------------------------------------
# Local Environment

variable "user_home" {
  type    = string
  default = "${env("HOME")}"
}

# ----------------------------------------
# Locals

locals {
  vm_name_postfix = "${legacy_isotime("20060102")}"
  vm_name = "${var.vm_name_prefix}-${var.image_name}-${local.vm_name_postfix}"
}

# ============================================================================
# SOURCE
# ============================================================================

source "proxmox-lxc" "jeffs-lxc-debian" {

  # ---------------------------------------------------------------
  # STEP 1 — Packer calls Proxmox API over HTTPS to create the VM
  #          Like clicking "Create Container" in the UI and filling in all
  #          the hardware screens (cores, memory, disk, network)
  # ---------------------------------------------------------------

  # ----------------------------------------
  # Proxmox Connection

  proxmox_url               = "${var.proxmox_url}"
  username                  = "${var.proxmox_token_id}"
  token                     = "${var.proxmox_token_secret}"
  insecure_skip_tls_verify  = true
  node                      = "${var.proxmox_node}"

  # ----------------------------------------
  # Container Identity

  vm_id                     = "${var.vm_id}"
  vm_name                   = "${local.vm_name}"
  template_description      = "${var.image_description}"
  unprivileged              = true

  # ----------------------------------------
  # VM Hardware

  cores                     = "${var.cores}"
  memory                    = "${var.memory}"

  # ---------------------------------------------------------------
  # STEP 2 — Proxmox downloads the LXC template tarball
  #          Stored at: /var/lib/vz/template/cache/ on the Proxmox machine
  # ---------------------------------------------------------------

  # ----------------------------------------
  # OS Template

  ostemplate                = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
  ostemplate_storage        = "local"
  ostemplate_url            = "http://download.proxmox.com/images/system/debian-12-standard_12.12-1_amd64.tar.zst"

  # ----------------------------------------
  # Root Filesystem

  rootfs_storage_pool       = "${var.storage_pool}"
  rootfs_size               = "${var.disk_size}"

  # ---------------------------------------------------------------
  # STEP 3 — Proxmox creates and starts the container directly
  #          No ISO boot, no HTTP server, no boot commands needed
  # ---------------------------------------------------------------

  network_interfaces {
    name                    = "eth0"
    bridge                  = "vmbr0"
    ip                      = "${var.network_ip}"
    gw                      = "${var.network_gw}"
  }

  # ---------------------------------------------------------------
  # STEP 4 — Packer SSHes into the container
  #          Uses SSH key auth
  #          Once connected, the build block provisioners take over
  # ---------------------------------------------------------------

  # ----------------------------------------
  # SSH / Communicator

  communicator              = "ssh"
  ssh_username              = "${var.ssh_username}"
  ssh_private_key_file = "${var.user_home}/${var.ssh_private_key_file}"
  ssh_public_keys      = file("${var.user_home}/${var.ssh_public_key_file}")
  ssh_host                  = "${var.ssh_host}"
  ssh_timeout               = "10m"
  ssh_pty                   = true
  ssh_agent_auth            = false

  # ---------------------------------------------------------------
  # STEP 5 — After build block finishes, Packer calls API one more time
  #          to convert the container into a Proxmox template
  #          Ready to clone into new containers via Proxmox UI or Terraform
  # ---------------------------------------------------------------

}

# ============================================================================
# BUILD
# ============================================================================

# This block runs AFTER source completes and Packer has SSHed into the VM.
# Everything here executes INSIDE the VM over SSH.
#
# The sequence is:
# 1 - Short pause, then transfer files from your local machine to /tmp on VM
# 2 - Run install scripts in order inside the VM
# 3 - Packer disconnects and converts VM to a Proxmox template

build {

  sources = ["source.proxmox-lxc.jeffs-lxc-debian"]

  # ---------------------------------------------------------------
  # STEP 1 — Pause
  #          This pause gives the VM a moment to fully settle after SSH connects.
  #          Without this, the file transfers that follow can fail because the
  #          VM isn't quite ready yet even though SSH is up.
  # ---------------------------------------------------------------

  provisioner "shell" {
    inline       = ["echo THIS IS NEEDED!!! Only doing this to add a pause before file transfers"]
    pause_before = "3s"
    pause_after  = "3s"
  }

  # ---------------------------------------------------------------
  # STEP 2 — File Transfers (Your Machine -> /tmp on VM over SSH)
  #          These copy files from your local machine into /tmp on the VM.
  #          They land in /tmp first because the packer user may not have
  #          write access elsewhere. Your install scripts move them to
  #          their final destinations later.
  # ---------------------------------------------------------------

  provisioner "file" {
    destination             = "/tmp/packer_github_temp"
    source                  = "${var.user_home}/.ssh/packer_github_temp"
  }

  provisioner "file" {
    destination             = "/tmp/packer_github_temp.pub"
    source                  = "${var.user_home}/.ssh/packer_github_temp.pub"
  }

  provisioner "file" {
    destination             = "/tmp/welcome.txt"
    source                  = "./install-files/welcome.txt"
  }

  provisioner "file" {
    destination             = "/tmp/.dircolors"
    source                  = "./install-files/.dircolors"
  }

  provisioner "file" {
  destination               = "/tmp/hello-go.service"
  source                    = "./install-files/hello-go.service"
  }

  # ---------------------------------------------------------------
  # STEP 3 — Install Scripts (run inside VM over SSH in order)
  #          Each script is copied to the VM and executed as root via sudo.
  #          They run sequentially — if one fails, Packer stops.
  #          execute_command runs each script as root so installs work correctly.
  # ---------------------------------------------------------------

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    pause_before    = "4s"
    scripts         = [

      # USER SETUP
      "./install-scripts/user-setup-jeff.sh",

      # SECURITY (SSH KEYS)
      "./install-scripts/security-move-packer-github-temp-keys-to-jeff.sh",

      # PROVISIONING (SYSTEM LEVEL)
      "./install-scripts/provisioning-update-upgrade.sh",
      "./install-scripts/provisioning-install-packages.sh",
      "./install-scripts/provisioning-install-go-and-configure-for-root.sh",

      # CONFIGURE (USER LEVEL)
      "./install-scripts/configure-move-welcome-file-to-jeff.sh",
      "./install-scripts/configure-bashrc-for-root.sh",
      "./install-scripts/configure-bashrc-for-jeff.sh",
      "./install-scripts/configure-git-for-jeff.sh",
      "./install-scripts/configure-dircolors-for-jeff.sh",
      "./install-scripts/configure-prompt-for-jeff.sh",
      "./install-scripts/configure-go-for-jeff.sh",
      "./install-scripts/configure-pull-repos-for-jeff.sh",

      # SERVICES
      "./install-scripts/services-install-hello-go.sh",
      "./install-scripts/services-enable-at-boot.sh",

      # CLEANUP
      "./install-scripts/cleanup-packer-github-temp-keys.sh"

    ]
  }

  # ---------------------------------------------------------------
  # STEP 4 — Packer disconnects SSH
  #          Proxmox API call converts the VM into a reusable template.
  #          The template is now ready to clone via Proxmox UI or Terraform.
  # ---------------------------------------------------------------

}
