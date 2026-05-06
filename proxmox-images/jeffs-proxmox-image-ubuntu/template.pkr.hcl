# my-packer-image-builds jeffs-proxmox-image-ubuntu

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
# VM Identity

variable "vm_id" {
  type    = number
  default = 500
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
variable "network_model" {
  type    = string
  default = "virtio"
}
variable "network_bridge" {
  type    = string
  default = "vmbr0"
}

# ----------------------------------------
# Source Image (ISO)

variable "iso_url" {
  type    = string
  default = "https://releases.ubuntu.com/26.04/ubuntu-26.04-live-server-amd64.iso"
}
variable "iso_checksum" {
  type    = string
  default = "sha256:dec49008a71f6098d0bcfc822021f4d042d5f2db279e4d75bdd981304f1ca5d9"
}

# ----------------------------------------
# SSH / Communicator

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "ssh_host" {  # Use Static IP during build - It's temporary
  type = string
  default = "192.168.20.250"
}

# ----------------------------------------
# Local Environment

variable "user_home" {
  type    = string
  default = "${env("HOME")}"
}

variable "http_bind_address" {
  type = string
  default = "192.168.20.122"
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

source "proxmox-iso" "jeffs-ubuntu" {

  # ---------------------------------------------------------------
  # STEP 1 — Packer calls Proxmox API over HTTPS to create the VM
  #          Like clicking "Create VM" in the UI and filling in all
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
  # VM Identity

  vm_id                     = "${var.vm_id}"
  vm_name                   = "${local.vm_name}"
  template_description      = "${var.image_description}"
  os                        = "l26"
  qemu_agent                = true # Enables Proxmox guest agent after install

  # ----------------------------------------
  # VM Hardware

  cores                     = "${var.cores}"
  memory                    = "${var.memory}"
  disks {
    disk_size               = "${var.disk_size}"
    storage_pool            = "${var.storage_pool}"
    type                    = "scsi"
  }
  network_adapters {
    model                   = "${var.network_model}"
    bridge                  = "${var.network_bridge}"
  }
  vm_interface              = "ens18"

  # ---------------------------------------------------------------
  # STEP 2 — Proxmox downloads the ISO over HTTPS
  #          Stored at: /var/lib/vz/template/iso/ on the Proxmox Machine
  #          iso_checksum verifies the download wasn't corrupted
  # ---------------------------------------------------------------

  # ----------------------------------------
  # Source Image (ISO)

  # Using iso_url (download) - needs iso_storage_pool to know where to store it
  #boot_iso {
  #  iso_url                = "${var.iso_url}"
  #  iso_checksum           = "${var.iso_checksum}"
  #  iso_storage_pool       = "local"
  #  unmount                = true
  #}

  # Using iso_file (already on Proxmox) - no iso_storage_pool needed
  boot_iso {
    iso_file                = "local:iso/6a41473a3ae3f4b08ae6fad7ca5085979c1f4fd9.iso"
    iso_checksum            = "${var.iso_checksum}"
    unmount                 = true
  }

  # ---------------------------------------------------------------
  # STEP 3 — Packer calls API again to power on the VM
  #          VM boots from the ISO like a bare metal server
  #          booting from a USB stick for the first time
  # ---------------------------------------------------------------

  # ---------------------------------------------------------------
  # STEP 4 — Packer spins up a temporary HTTP server on YOUR machine
  #          serving the http/ folder (user-data and meta-data)
  #          This happens before boot commands are sent
  # ---------------------------------------------------------------

  http_directory            = "http"
  http_bind_address         = "${var.http_bind_address}"

  # ---------------------------------------------------------------
  # STEP 5 — Packer sends boot commands via VNC to the VM console
  #          This is literally Packer sitting at the keyboard for you,
  #          typing keystrokes into the VM console to trigger autoinstall
  # ---------------------------------------------------------------

  # ---------------------------------------------------------------
  # STEP 6 — VM fetches /user-data over HTTP from your machine
  #          The URL in the boot command tells the Ubuntu installer
  #          where to get its config (disk, username, password, etc.)
  #          This replaces clicking through the Ubuntu setup screens
  # ---------------------------------------------------------------

  boot_wait                 = "20s"
  boot_command              = [
    "<esc><wait>",                                         # interrupt GRUB menu
    "e<wait>",                                             # edit the boot entry
    "<down><down><down><end>",                             # navigate to end of kernel line
    "<bs><bs><bs><bs><wait>",                              # delete existing "---" at end of line
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"                                          # boot with modified command
  ]

  # ---------------------------------------------------------------
  # STEP 7 — VM reboot
  # ---------------------------------------------------------------

  # ---------------------------------------------------------------
  # STEP 8 — Packer SSHes into the VM
  #          Uses SSH key auth set in user-data authorized-keys
  #          20 minute timeout gives the installer time to finish
  #          before Packer starts trying to connect
  #          Once connected, the build block provisioners take over
  # ---------------------------------------------------------------

  # ----------------------------------------
  # SSH / Communicator

  communicator              = "ssh"
  ssh_username              = "${var.ssh_username}"
  ssh_private_key_file      = "~/.ssh/id_rsa"
  ssh_host                  = "${var.ssh_host}"
  ssh_timeout               = "90m"
  ssh_pty                   = true
  ssh_agent_auth            = false

  # ---------------------------------------------------------------
  # STEP 9 — After build block finishes, Packer calls API one more time
  #          to convert the VM into a Proxmox template
  #          Ready to clone into new VMs via Proxmox UI or Terraform
  # ---------------------------------------------------------------

  # ----------------------------------------
  # CLOUD INIT
  # Adds a cloud-init drive to the template so when you clone it
  # you can inject SSH keys, username, IP config without rebuilding
  cloud_init                = true
  cloud_init_storage_pool   = "${var.storage_pool}"

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

  sources = ["source.proxmox-iso.jeffs-ubuntu"]

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
    destination             = "/tmp/proxmox_universal.pub"
    source                  = "${var.user_home}/.ssh/proxmox_universal.pub"
  }

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
    destination             = "/tmp/settings.json"
    source                  = "./install-files/settings.json"
  }

  provisioner "file" {
    destination             = "/tmp/hello-go.service"
    source                  = "./install-files/hello-go.service"
  }

  # ---------------------------------------------------------------
  # STEP 3 — Install Scripts (run inside VM over SSH in order)
  #          Each script is copied to the VM and executed as root via sudo.
  #          They run sequentially — if one fails, Packer stops.
  #          execute_command runs each script as root so installs work correctly.
  # ---------------------------------------------------------------

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E {{ .Path }}"
    pause_before    = "4s"
    scripts         = [

      # USER SETUP
      "./install-scripts/user-setup-jeff.sh",

      # SECURITY (SSH KEYS)
      "./install-scripts/security-prepend-proxmox-universal-key-to-authorized-keys-jeff.sh",
      "./install-scripts/security-move-packer-github-temp-keys-to-jeff.sh",

      # PROVISIONING (SYSTEM LEVEL)
      "./install-scripts/provisioning-update-upgrade.sh",
      "./install-scripts/provisioning-install-packages.sh",
      "./install-scripts/provisioning-install-docker.sh",
      "./install-scripts/provisioning-run-a-dockerhub-image-at-boot.sh",
      "./install-scripts/provisioning-install-go-and-configure-for-root.sh",

      # CONFIGURE (USER LEVEL)
      "./install-scripts/configure-move-welcome-file-to-jeff.sh",
      "./install-scripts/configure-bashrc-for-root.sh",
      "./install-scripts/configure-bashrc-for-jeff.sh",
      "./install-scripts/configure-git-for-jeff.sh",
      "./install-scripts/configure-dircolors-for-jeff.sh",
      "./install-scripts/configure-prompt-for-jeff.sh",
      "./install-scripts/configure-go-for-jeff.sh",
      "./install-scripts/configure-move-vscode-server-settings-file-to-jeff.sh",
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
