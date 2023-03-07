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
  boot_command = [
    "e<down><down><down><end>",
    " autoinstall ds=nocloud;",
    "<F10>"
  ]
  boot_wait               = "15s"
  boot_order              = "disk,cdrom"
  cd_files = [
        "./http/meta-data",
        "./http/user-data"
    ]
  cd_label = "cidata"
  guest_os_type           = "Ubuntu_64"
  headless                = false
  http_directory          = "http"
  iso_urls                = [
    "${var.iso_urls1}"
    ]
  iso_checksum            = "md5:${var.iso_checksum_md5}"
  shutdown_command        = "echo 'packer' | sudo -S shutdown -P now"
  ssh_username            = "packer"
  ssh_password            = "packer"
  ssh_port                = 22
  ssh_timeout             = "10000s"
  vboxmanage              = [
    ["modifyvm", "{{ .Name }}", "--memory", "4096"],
    ["modifyvm", "{{ .Name }}", "--cpus", "4"]
  ]
  #virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.vm_name}"
  output_directory        = "output-virtualbox"
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
