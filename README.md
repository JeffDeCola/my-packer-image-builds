# MY PACKER IMAGE BUILDS

[![codeclimate Issue Count](https://codeclimate.com/github/JeffDeCola/my-packer-image-builds/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/my-packer-image-builds/issues)
[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

_A place to keep my packer image builds._

tl;dr,

```bash
## BUILD IMAGE
packer build template.pkr.hcl

## OTHER COMMANDS
packer validate template.pkr.hcl
```

Table of Contents

* [OVERVIEW](https://github.com/JeffDeCola/my-packer-image-builds#overview)
* [DOCKER IMAGES](https://github.com/JeffDeCola/my-packer-image-builds#docker-images)
* [GOOGLE COMPUTE ENGINE (GCE) IMAGES](https://github.com/JeffDeCola/my-packer-image-builds#google-compute-engine-gce-images)
* [VAGRANT IMAGES](https://github.com/JeffDeCola/my-packer-image-builds#vagrant-images)
* [VIRTUALBOX IMAGES](https://github.com/JeffDeCola/my-packer-image-builds#virtualbox-images)

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* An illustration of
  [vagrant, docker and packer](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet#vagrant-docker-and-packer)
* This repos
  [github webpage](https://jeffdecola.github.io/my-packer-image-builds/)
  _built with
  [concourse](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/ci-README.md)_

## OVERVIEW

These builds use the following statement,

**Using packer to build a/an {IMAGE OS} {CUSTOM IMAGE FILE} image for {PLATFORM TOOL}
on {HOST OS}.**

Where,

* **IMAGE OS**: ubuntu/alpine/windows
* **CUSTOM IMAGE FILE**: docker/gce/vagrant/virtualbox
* **PLATFORM TOOL**: docker/gce/virtualbox
* **HOST OS**: linux/windows

## DOCKER IMAGES

_You can use packer, but docker is easier._

* [jeffs-alpine-docker-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-alpine-docker-image)

  _Using packer to build an alpine docker image for docker on linux._
  
* [jeffs-ubuntu-2204-docker-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-ubuntu-2204-docker-image)

  _Using packer to build an ubuntu 22.04 docker image for docker on linux._

## GOOGLE COMPUTE ENGINE (GCE) IMAGES

* [jeffs-ubuntu-2204-gce-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image)

  _Using packer to remotely build an ubuntu 22.04 gce image for gce on linux._

## VAGRANT IMAGES

* [jeffs-ubuntu-2204-vagrant-image-for-virtualbox-on-linux](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-ubuntu-2204-vagrant-image-for-virtualbox-on-linux)

  _Using packer to build an ubuntu 22.04 vagrant image for virtualbox on linux._

* [jeffs-ubuntu-2204-vagrant-image-for-virtualbox-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-ubuntu-2204-vagrant-image-for-virtualbox-on-windows)

  _Using packer to build an ubuntu 22.04 vagrant image for virtualbox on windows._

* [jeffs-windows-11-vagrant-image-for-virtualbox-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-windows-11-vagrant-image-for-virtualbox-on-windows)

  _Using packer to build a windows 11 vagrant image for virtualbox on windows._

## VIRTUALBOX IMAGES

* [jeffs-ubuntu-2204-virtualbox-image-for-virtualbox-on-linux](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-ubuntu-2204-virtualbox-image-for-virtualbox-on-linux)

  _Using packer to build an ubuntu 22.04 virtualbox image for virtualbox on linux._

* [jeffs-ubuntu-2204-virtualbox-image-for-virtualbox-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-ubuntu-2204-virtualbox-image-for-virtualbox-on-windows)

  _Using packer to build an ubuntu 22.04 virtualbox image for virtualbox on windows._

* [jeffs-windows-11-virtualbox-image-for-virtualbox-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-windows-11-virtualbox-image-for-virtualbox-on-windows)

  _Using packer to build a windows 11 virtualbox image for virtualbox on windows._
