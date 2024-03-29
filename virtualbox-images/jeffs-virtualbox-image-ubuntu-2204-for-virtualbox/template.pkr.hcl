variable "iso_checksum_md5" {
  type    = string
  default = "33993f79ba694f1dba9fcf89f11257ea"
}

variable "iso_urls1" {
  type    = string
  default = "iso/ubuntu-22.04.2-live-server-amd64.iso"
}

variable "vm_name" {
  type    = string
  default = "jeffs-virtualbox-image-ubuntu-2204-for-virtualbox"
}

source "virtualbox-iso" "example" {
  cd_files = [
    "./http/user-data",
    "./http/meta-data"
  ]
  cd_label = "cidata"
  boot_command          = [
    "<enter><wait2><enter><wait><f6><esc><wait>",
    "linux /casper/vmlinuz autoinstall ds=nocloud;",
    "<wait><enter>",
    "initrd /casper/initrd",
    "<wait><enter>",
    "boot"
  ]
  # May have to adjust time. You want to hit that GNU boot screen perfectly.
  boot_wait               = "15s"
  guest_os_type           = "Ubuntu_64"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  headless                = false
  http_directory          = "./http"
  iso_urls                = [
    "${var.iso_urls1}"
    ]
  iso_checksum            = "md5:${var.iso_checksum_md5}"
  shutdown_command        = "echo 'packer' | sudo -S shutdown -P now"
  # I think you need ubuntu ubuntu for the ssh_username and ssh_password
  ssh_agent_auth          = true
  ssh_handshake_attempts  = "200"
  ssh_username            = "packer"
  ssh_password            = "packer"
  ssh_port                = 22
  ssh_timeout             = "10000s"
  vboxmanage              = [
    ["modifyvm", "{{ .Name }}", "--memory", "8192"],
    ["modifyvm", "{{ .Name }}", "--cpus", "3"]
  ]
  vm_name                 = "${var.vm_name}"
  output_directory        = "output-virtualbox"
  virtualbox_version_file = ".vbox_version"
}

build {
  sources = ["source.virtualbox-iso.example"]

  provisioner "file" {
    destination = "/tmp/welcome.txt"
    source      = "./install-files/welcome.txt"
  }

  provisioner "shell" {
    execute_command = "echo 'packer' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    pause_before    = "4s"
    scripts         = [
      "./install-scripts/update-upgrade-system.sh",
      "./install-scripts/install-packages.sh",
      "./install-scripts/add-user-jeff.sh",
      "./install-scripts/move-welcome-file-to-packer.sh",
    ]
  }

}
