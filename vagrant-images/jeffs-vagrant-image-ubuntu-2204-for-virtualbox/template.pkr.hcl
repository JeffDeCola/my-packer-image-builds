# my-packer-image-builds jeffs-vagrant-image-ubuntu-2204-for-virtualbox

# Note: image=box

# Vagrant source image (box) for virtualbox
variable "souce_image" {
  type    = string
  default = "generic/ubuntu2204" 
}

# Vagrant custom image (box) for virtualbox
variable "provider" {
  type    = string
  default = "virtualbox" 
}

# Virtualbox name
variable "custom_image_name" {
  type    = string
  default = "jeffs-vagrant-image-ubuntu-2204-for-virtualbox"
}

source "vagrant" "example" {
  provider = "${var.provider}"
  communicator = "ssh"
  source_path = "${var.souce_image}"
  add_force = false
  output_dir = "box"
  box_name = "${var.custom_image_name}"
}

build {
  sources = [
    "source.vagrant.example"
  ]

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
    scripts         = [
      "./install-scripts/update-upgrade-system.sh",
      "./install-scripts/install-packages.sh",
      "./install-scripts/add-user-jeff.sh",
      "./install-scripts/move-welcome-file-to-vagrant.sh",
      "./install-scripts/move-vagrant-insecure-public-key.sh",
    ]
  } 

  # post-processor "vagrant" {
  #  compression_level = "5"
  #  output            = "box/${var.vm_name}.box"
  # }
  
}
