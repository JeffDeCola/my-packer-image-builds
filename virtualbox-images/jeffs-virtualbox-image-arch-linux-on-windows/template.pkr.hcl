# my-packer-image-builds jeffs-virtualbox-image-arch-linux

# ============================================================================
# PLUGINS
# ============================================================================

packer {
  required_plugins {
    virtualbox = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

# ============================================================================
# VARIABLES
# ============================================================================

# ----------------------------------------
# VM Identity

variable "vm_name_prefix" {
  type    = string
  default = "jeffs"
}
variable "image_name" {  # FROM COMMAND
  type    = string
  default = ""
}

# ----------------------------------------
# VM Hardware

variable "cores" {
  type    = number
  default = 4
}
variable "memory" {
  type    = number
  default = 8192
}
variable "disk_size" {
  type    = string
  default = "40960"  # MB - 40GB
}

# ----------------------------------------
# Source Image (ISO)

variable "iso_url" {
  type    = string
  default = "https://mirrors.kernel.org/archlinux/iso/latest/archlinux-x86_64.iso"
}
variable "iso_checksum" {
  type    = string
  default = "file:https://mirrors.kernel.org/archlinux/iso/latest/sha256sums.txt"
}

# ----------------------------------------
# SSH / Communicator

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "ssh_private_key_file" {
  type    = string
  default = "~/.ssh/virtualbox_universal"
}

# ----------------------------------------
# Local Environment

variable "user_home" {
  type    = string
  default = "${env("HOME")}"
}
variable "vm_base_dir" {
  type    = string
  default = "D:/virtualbox"
}

# ----------------------------------------
# Locals

locals {
  vm_name_postfix = "${legacy_isotime("20060102")}"
  vm_name         = "${var.vm_name_prefix}-${var.image_name}-${local.vm_name_postfix}"
}

# ============================================================================
# SOURCE
# ============================================================================

source "virtualbox-iso" "jeffs-arch-linux" {

  # ---------------------------------------------------------------
  # STEP 1 — Packer creates the VM in VirtualBox
  #          Like clicking "New" in the VirtualBox UI and filling in
  #          all the hardware screens (cores, memory, disk, network)
  # ---------------------------------------------------------------

  # ----------------------------------------
  # VM Identity

  vm_name                   = "${local.vm_name}"

  # ----------------------------------------
  # Guest OS Type
  # Tells VirtualBox what kind of guest this is

  guest_os_type             = "ArchLinux_64"

  # ----------------------------------------
  # VM Hardware

  cpus                      = "${var.cores}"
  memory                    = "${var.memory}"
  disk_size                 = "${var.disk_size}"

  # ----------------------------------------
  # Storage Controllers

  iso_interface             = "sata"
  hard_drive_interface      = "sata"

  # ----------------------------------------
  # VM Storage Location

  output_directory          = "${var.vm_base_dir}/${local.vm_name}"

  # ----------------------------------------
  # HTTP Server
  # Packer spins up a temporary HTTP server on TK3-PC serving
  # the http/ folder. The live ISO fetches bootstrap.sh and
  # virtualbox_universal.pub from this server during boot.

  http_directory = "http"

  # ----------------------------------------
  # Network

  nic_type                  = "82540EM"

  # ---------------------------------------------------------------
  # STEP 2 — Packer downloads the ISO
  #          Downloaded and cached locally on TK3-PC
  #          iso_checksum verifies the download wasn't corrupted
  # ---------------------------------------------------------------

  # ----------------------------------------
  # Source Image (ISO)

  iso_url                   = "${var.iso_url}"
  iso_checksum              = "${var.iso_checksum}"

  # ---------------------------------------------------------------
  # STEP 3 — Packer sends boot commands via VNC to the VM console
  #          Arch ISO boots straight to a live root shell. We curl
  #          bootstrap.sh from Packer's HTTP server and run it,
  #          which creates the packer user with the universal key
  #          so Packer can SSH in.
  # ---------------------------------------------------------------

  boot_keygroup_interval = "100ms"
  boot_wait = "90s"
  boot_command = [
    "<enter><wait90>",
    "<enter><wait5>",
    "<enter><wait5>",
    "<enter><wait5>",
    "setopt no_correct<enter><wait3>",
    "curl -o /tmp/bootstrap.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/bootstrap.sh<enter><wait15>",
    "ls /tmp/bootstrap.sh<enter><wait3>",
    "bash /tmp/bootstrap.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/virtualbox_universal.pub<enter><wait15>"
  ]

  # ---------------------------------------------------------------
  # STEP 4 — Packer SSHes into the live Arch environment as packer
  #          From here a shell script does the full install:
  #          partition, pacstrap, configure, install GRUB
  # ---------------------------------------------------------------

  # ----------------------------------------
  # SSH / Communicator

  communicator         = "ssh"
  ssh_username         = "${var.ssh_username}"
  ssh_private_key_file = "${var.ssh_private_key_file}"
  ssh_timeout          = "90m"
  ssh_agent_auth       = false

  # ----------------------------------------
  # Guest Additions
  # Disabled - we don't need VirtualBox guest additions
  # in a server image

  guest_additions_mode      = "disable"

  # ----------------------------------------
  # Shutdown

  shutdown_command          = "echo 'packer' | sudo -S shutdown -P now"

  # ---------------------------------------------------------------
  # STEP 6 — After build block finishes, Packer shuts down the VM
  #          VirtualBox keeps it registered and ready to start
  #          No template conversion needed unlike Proxmox
  # ---------------------------------------------------------------

}

# ============================================================================
# BUILD
# ============================================================================

# This block runs AFTER source completes and Packer has SSHed into the VM.
# Everything here executes INSIDE the live Arch environment over SSH.
#
# The sequence is:
# 1 - Run arch-install.sh which does the full installation:
#     partition, pacstrap, configure, GRUB, users, SSH keys
# 2 - Reboot into installed system
# 3 - Packer reconnects and runs post-install scripts
# 4 - Packer disconnects and VM stays registered in VirtualBox

build {

  sources = ["source.virtualbox-iso.jeffs-arch-linux"]

  # ---------------------------------------------------------------
  # STEP 1 — Pause
  #          Give the live environment a moment to settle
  # ---------------------------------------------------------------

  provisioner "shell" {
    inline       = ["echo THIS IS NEEDED!!! Only doing this to add a pause before file transfers"]
    pause_before = "3s"
    pause_after  = "3s"
  }

# ---------------------------------------------------------------
  # STEP 2 — Run Arch Install Script
  #          This script runs inside the live Arch environment
  #          and does the full installation:
  #          - Partition disk (ext4)
  #          - pacstrap base system
  #          - Configure fstab, locale, timezone, hostname
  #          - Install and configure GRUB
  #          - Create packer and jeff users
  #          - Set up SSH keys
  #          - Reboot into installed system
  # ---------------------------------------------------------------

  provisioner "file" {
    destination = "/tmp/arch-install.sh"
    source      = "./install-scripts/arch-install.sh"
  }

  provisioner "shell" {
    expect_disconnect = true
    inline = [
      "chmod +x /tmp/arch-install.sh",
      "sudo /tmp/arch-install.sh"
    ]
  }

  # ---------------------------------------------------------------
  # STEP 3 — File Transfers (Your Machine -> /tmp on VM over SSH)
  #          Packer has reconnected to the installed Arch system
  #          Same files as Ubuntu build
  # ---------------------------------------------------------------

  provisioner "file" {
    pause_before = "30s"
    destination             = "/tmp/virtualbox_universal.pub"
    source                  = "${var.user_home}/.ssh/virtualbox_universal.pub"
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
  # STEP 4 — Post-Install Scripts
  #          Same scripts as Ubuntu but Arch versions
  #          (pacman instead of apt, etc.)
  # ---------------------------------------------------------------

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E {{ .Path }}"
    pause_before    = "4s"
    scripts         = [

      # SECURITY (SSH KEYS)
      "./install-scripts/security-prepend-virtualbox-universal-key-to-authorized-keys-jeff.sh",
      "./install-scripts/security-move-packer-github-temp-keys-to-jeff.sh",

      # PROVISIONING (SYSTEM LEVEL)
      "./install-scripts/provisioning-update-upgrade.sh",
      "./install-scripts/provisioning-run-a-dockerhub-image-at-boot.sh",

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
  # STEP 5 — Packer disconnects SSH
  #          VM stays registered in VirtualBox on TK3-PC
  #          Ready to start via VirtualBox UI
  # ---------------------------------------------------------------

}