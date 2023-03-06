#variable "disk_size" {
#  type    = string
#  default = "61440"
#}

variable "guest_os_type" {
  type    = string
  default = "Ubuntu_64"
}

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
  #boot_command            = ["<esc><wait>", "<esc><wait>", "<enter><wait>", "/install/vmlinuz<wait>", " auto<wait>", " console-setup/ask_detect=false<wait>", " console-setup/layoutcode=us<wait>", " console-setup/modelcode=pc105<wait>", " debconf/frontend=noninteractive<wait>", " debian-installer=en_US<wait>", " fb=false<wait>", " initrd=/install/initrd.gz<wait>", " kbd-chooser/method=us<wait>", " keyboard-configuration/layout=USA<wait>", " keyboard-configuration/variant=USA<wait>", " locale=en_US<wait>", " netcfg/get_domain=vm<wait>", " netcfg/get_hostname=vagrant<wait>", " grub-installer/bootdev=/dev/sda<wait>", " noapic<wait>", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<wait>", " -- <wait>", "<enter><wait>"]
  #boot_wait               = "10s"
  #disk_size               = "${var.disk_size}"
  #guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "${var.guest_os_type}"
  headless                = true
  #http_directory          = "http"
  iso_urls                = [
    "${var.iso_urls1}"
    ]
  iso_checksum            = "md5:${var.iso_checksum_md5}"
  shutdown_command        = "echo 'packer' | sudo -S shutdown -P now"
  ssh_username            = "packer"
  ssh_password            = "packer"
  #ssh_port                = 22
  #ssh_wait_timeout        = "10000s"
  vboxmanage              = [
    ["modifyvm", "{{ .Name }}", "--memory", "4096"],
    ["modifyvm", "{{ .Name }}", "--cpus", "4"]
  ]
  #virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.vm_name}"
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
