# MY PACKER IMAGE BUILDS

[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)
[![MIT License](https://img.shields.io/:license-mit-blue.svg)](https://jeffdecola.mit-license.org)

_A place to keep my packer image builds._

tl;dr

```bash
## BUILD IMAGE
packer build template.pkr.hcl

## VALIDATE TEMPLATE FILE
packer validate template.pkr.hcl
```

Table of Contents

* [OVERVIEW](https://github.com/JeffDeCola/my-packer-image-builds#overview)
* [DOCKER IMAGES](https://github.com/JeffDeCola/my-packer-image-builds#docker-images)
* [GOOGLE COMPUTE ENGINE (GCE) IMAGES](https://github.com/JeffDeCola/my-packer-image-builds#google-compute-engine-gce-images)
* [PROXMOX IMAGES](https://github.com/JeffDeCola/my-packer-image-builds#proxmox-images)
* [VAGRANT IMAGES (BOX)](https://github.com/JeffDeCola/my-packer-image-builds#vagrant-images-box)
* [VIRTUALBOX IMAGES](https://github.com/JeffDeCola/my-packer-image-builds#virtualbox-images)

Documentation and Reference

* [packer](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* An illustration of how
  [vagrant, docker and packer](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet#vagrant-docker-and-packer)
  build and deploy images
* This repos
  [github webpage](https://jeffdecola.github.io/my-packer-image-builds/)
  _built with
  [concourse](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/ci-README.md)_

## OVERVIEW

Packer is useful for the automated **BUILD** of a custom image.

![IMAGE - packer-overview - IMAGE](docs/pics/packer-overview.svg)

These builds use the following statement,

**Using packer to build a/an {CUSTOM IMAGE FILE} image
containing the {CUSTOM IMAGE OS} OS
for {PROVIDER TOOL} on {HOST OS}.**

Where,

* **CUSTOM IMAGE FILE**: docker/gce/proxmox/vagrant/virtualbox/etc.
* **CUSTOM IMAGE OS**: ubuntu/alpine/windows/etc.
* **PROVIDER TOOL**: docker/gce/proxmox/virtualbox/etc.
* **HOST OS**: linux/windows

## DOCKER IMAGES

_Legacy code. You can also build docker images using a Dockerfile as shown in
[my-docker-image-builds](https://github.com/JeffDeCola/my-docker-image-builds)._

* [jeffs-docker-image-alpine](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-alpine)

  _Using packer to build a docker image
  containing the alpine OS
  for docker on linux._

* [jeffs-docker-image-ubuntu-2204](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-ubuntu-2204)

  _Using packer to build a docker image
  containing the ubuntu 22.04 OS
  for docker on linux._

## GOOGLE COMPUTE ENGINE (GCE) IMAGES

_You can also build gce images using gcloud cli or the gce gui._

* [jeffs-gce-image-ubuntu-2204](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204)

  _Using packer to remotely build a gce image
  containing the ubuntu 22.04 OS
  for gce on linux._

## PROXMOX IMAGES

_You can run packer on a different machine._

* [jeffs-proxmox-image-ubuntu](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-ubuntu)

  _Using packer to remotely build a proxmox image
  containing the ubuntu OS
  for proxmox on linux._

## VAGRANT IMAGES (BOX)

_Legacy code._

* [jeffs-vagrant-image-ubuntu-2204-for-virtualbox](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox)

  _Using packer to build a vagrant image (box)
  containing the ubuntu 22.04 OS
  for virtualbox on linux or windows._

## VIRTUALBOX IMAGES

_You must run packer on the same machine._

* [jeffs-virtualbox-image-arch-linux-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows)

  _Using packer to build a virtualbox image
  from an Arch Linux iso
  containing the Arch Linux rolling-release OS
  for virtualbox on windows._

* [jeffs-virtualbox-image-debian-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-debian-on-windows)

  _Using packer to build a virtualbox image
  from a Debian iso
  containing the Debian 13 (Trixie) OS
  for virtualbox on windows._

* [jeffs-virtualbox-image-ubuntu-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows)

  _Using packer to build a virtualbox image
  from an ubuntu 26.04 iso
  containing the ubuntu 26.04 OS
  for virtualbox on windows._
