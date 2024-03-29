# my-packer-image-builds jeffs-docker-image-ubuntu-2204

variable "image_os" {
  type    = string
  default = "ubuntu:jammy"
}

source "docker" "example" {
  image  = "${var.image_os}"
  commit = true
  pull  = true
}

build {
  name = "jeffs-docker-image-ubuntu-2204"
  sources = [
    "source.docker.example"
  ]

  # Pause
  provisioner "shell" {
    inline       = [
      "echo THIS IS NEEDED!!! Only doing this to add a pause before file transfers"
    ]
    pause_after  = "1s"
    pause_before = "1s"
  }

  # Load a file onto image
  provisioner "file" {
    destination = "/tmp/welcome.txt"
    source      = "./install-files/welcome.txt"
  }

  # Provision
  provisioner "shell" {
    # execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E {{ .Path }}"
    pause_before    = "1s"
    scripts         = [
      "./install-scripts/update-upgrade-system.sh",
      "./install-scripts/install-packages.sh",
      "./install-scripts/move-welcome-file-to-root.sh"
    ]
  }

  post-processor "shell-local" {
    inline = ["echo Done"]
  }

  post-processor "docker-tag" {
    repository = "jeffdecola/my-packer-image-builds/jeffs-docker-image-ubuntu-2204"
  }

}
