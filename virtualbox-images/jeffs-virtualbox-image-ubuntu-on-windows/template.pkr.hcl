# my-packer-image-builds jeffs-virtualbox-image-ubuntu

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

source "virtualbox-iso" "jeffs-ubuntu" {

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
  # Tells VirtualBox what kind of guest this is so it picks
  # sane chipset, audio, and controller defaults

  guest_os_type             = "Ubuntu_64"

  # ----------------------------------------
  # VM Hardware

  cpus                      = "${var.cores}"
  memory                    = "${var.memory}"
  disk_size                 = "${var.disk_size}"

  # ----------------------------------------
  # Storage Controllers
  # Attach both the install ISO and the virtual hard disk via SATA
  # instead of the default IDE. IDE attachment of the ISO has been
  # unreliable on recent VirtualBox versions - the ISO ends up not
  # mounted in the VM, GRUB can't find /casper/vmlinuz, and the
  # boot_command silently fails at the rescue prompt

  iso_interface             = "sata"
  hard_drive_interface      = "sata"

  # ----------------------------------------
  # VM Storage Location

  output_directory          = "${var.vm_base_dir}/${local.vm_name}"

  # ----------------------------------------
  # Network
  # NAT is default - Packer SSHes in via port forwarding
  # No bridge needed unlike Proxmox

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
  # STEP 3 — Packer spins up a temporary HTTP server on TK3-PC
  #          serving the http/ folder (user-data and meta-data)
  #          Ubuntu installer fetches user-data from this server
  # ---------------------------------------------------------------

  http_directory            = "http"

  # ---------------------------------------------------------------
  # STEP 4 — Packer sends boot commands via VNC to the VM console
  #          Packer types keystrokes into the VM console to trigger
  #          autoinstall and point it at the HTTP server
  # ---------------------------------------------------------------

  # must time this correctly or you miss the grub menu
  boot_wait = "10s"
  boot_command = [
    "c<wait5>",
    "set root=(cd)<enter><wait>",
    "linux /casper/vmlinuz autoinstall ds=\"nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\" ---<enter><wait5>",
    "initrd /casper/initrd<enter><wait5>",
    "boot<enter>"
  ]

  # ---------------------------------------------------------------
  # STEP 5 — Packer SSHes into the VM via NAT port forwarding
  #          VirtualBox automatically forwards a local port to the VM
  #          No static IP needed unlike Proxmox
  #          90 minute timeout gives the installer time to finish
  # ---------------------------------------------------------------

  # ----------------------------------------
  # SSH / Communicator

  communicator              = "ssh"
  ssh_username              = "${var.ssh_username}"
  ssh_private_key_file      = "~/.ssh/virtualbox_universal"
  ssh_timeout               = "90m"
  ssh_agent_auth            = false

  # ----------------------------------------
  # Guest Additions
  # Disabled - we don't need VirtualBox guest additions
  # in a server image

  guest_additions_mode      = "disable"

  # ----------------------------------------
  # Shutdown

  shutdown_command          = "echo 'packer' | sudo -S shutdown -P now"

  # ----------------------------------------
  # Output Format
  # By default, the virtualbox-iso builder exports the VM as an OVF
  # appliance at the end of the build, which then has to be imported
  # back into VirtualBox to use. Setting skip_export = true keeps the
  # VM registered directly in VirtualBox at the end of the build, ready
  # to clone from. The VM appears in the VirtualBox Manager UI sidebar
  # automatically.

  format                    = "ovf"
  skip_export               = true

  # ---------------------------------------------------------------
  # STEP 6 — After build block finishes, Packer shuts down the VM
  #          With skip_export = true, VirtualBox keeps it registered
  #          in the Manager UI and ready to clone from
  #          No template conversion needed unlike Proxmox
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
# 3 - Packer disconnects and VM stays registered in VirtualBox

build {

  sources = ["source.virtualbox-iso.jeffs-ubuntu"]

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
      "./install-scripts/security-prepend-virtualbox-universal-key-to-authorized-keys-jeff.sh",
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
  #          VM stays registered in VirtualBox on TK3-PC
  #          Ready to start via VirtualBox UI
  # ---------------------------------------------------------------

}
