variable "disk_size" {
  type    = string
  default = "61440"
}

variable "guest_os_type" {
  type    = string
  default = "Ubuntu_64"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "iso_checksum" {
  type    = string
  default = "a2cb36dc010d98ad9253ea5ad5a07fd6b409e3412c48f1860536970b073c98f5"
}

variable "iso_checksum_type" {
  type    = string
  default = "sha256"
}

variable "iso_urls1" {
  type    = string
  default = "iso/ubuntu-18.04.2-server-amd64.iso"
}

variable "vm_name" {
  type    = string
  default = "jeffs-ubuntu-1804-virtualbox-vm-box"
}
source "virtualbox-iso" "example" {
  boot_command            = ["<esc><wait>", "<esc><wait>", "<enter><wait>", "/install/vmlinuz<wait>", " auto<wait>", " console-setup/ask_detect=false<wait>", " console-setup/layoutcode=us<wait>", " console-setup/modelcode=pc105<wait>", " debconf/frontend=noninteractive<wait>", " debian-installer=en_US<wait>", " fb=false<wait>", " initrd=/install/initrd.gz<wait>", " kbd-chooser/method=us<wait>", " keyboard-configuration/layout=USA<wait>", " keyboard-configuration/variant=USA<wait>", " locale=en_US<wait>", " netcfg/get_domain=vm<wait>", " netcfg/get_hostname=vagrant<wait>", " grub-installer/bootdev=/dev/sda<wait>", " noapic<wait>", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<wait>", " -- <wait>", "<enter><wait>"]
  boot_wait               = "10s"
  disk_size               = "${var.disk_size}"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "${var.guest_os_type}"
  headless                = "${var.headless}"
  http_directory          = "http"
  iso_checksum            = "${var.iso_checksum}"
  iso_checksum_type       = "${var.iso_checksum_type}"
  iso_urls                = ["${var.iso_urls1}"]
  shutdown_command        = "echo 'vagrant'|sudo -S shutdown -P now"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_username            = "vagrant"
  ssh_wait_timeout        = "10000s"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "4096"], ["modifyvm", "{{ .Name }}", "--cpus", "4"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.vm_name}"
}

build {
  sources = ["source.virtualbox-iso.example"]

  provisioner "file" {
    destination = "/tmp/welcome.txt"
    source      = "./install-files/welcome.txt"
  }

  provisioner "file" {
    destination = "/tmp/vagrant-insecure-public-key.txt"
    source      = "./install-files/vagrant-insecure-public-key.txt"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    pause_before    = "4s"
    scripts         = ["./install-scripts/init.sh", "./install-scripts/move-welcome-file.sh", "./install-scripts/move-vagrant-insecure-public-key.sh", "./install-scripts/install-packages.sh", "./install-scripts/cleanup.sh"]
  }

  post-processor "vagrant" {
    compression_level = "5"
    output            = "box/${var.vm_name}.box"
  }
}
