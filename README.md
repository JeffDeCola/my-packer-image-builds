# MY PACKER IMAGE BUILDS

[![codeclimate Issue Count](https://codeclimate.com/github/JeffDeCola/my-packer-image-builds/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/my-packer-image-builds/issues)
[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

_A place to keep my packer image builds._

tl;dr,

```bash
## BUILD IMAGE
tbd

## OTHER COMMANDS
tbd
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
* This repos
  [github webpage](https://jeffdecola.github.io/my-packer-image-builds/)
  _built with
  [concourse](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/ci-README.md)_

## OVERVIEW

Using packer to build a/an {IMAGE OS} {CUSTOM IMAGE FILE} image for {PLATFORM TOOL}
on {HOST OS}.

Where,

* **IMAGE OS**: ubuntu/alpine/windows
* **CUSTOM IMAGE FILE**: docker/gce/vagrant/virtualbox
* **PLATFORM TOOL**: docker/gce/virtualbox
* **HOST OS**: linux/windows

## DOCKER IMAGES

_You can use packer, but docker is easier._

* [jeffs-alpine-docker-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/docker/jeffs-ubuntu-2202-docker-image)

  _Using packer to build an alpine docker image for docker on linux._
  
* [jeffs-ubuntu-2202-docker-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/docker/jeffs-ubuntu-2202-docker-image)

  _Using packer to build an ubuntu 22.04 docker image for docker on linux._

## GOOGLE COMPUTE ENGINE (GCE) IMAGES

* [jeffs-ubuntu-1904-gce-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/google-compute-engine/jeffs-ubuntu-1904-gce-image)

  _Using packer to remotely build an ubuntu 19.04 gce image for gce on linux._

* [jeffs-ubuntu-2004-gce-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/google-compute-engine/jeffs-ubuntu-2004-gce-image4)

  _Using packer to remotely build an ubuntu 20.04 gce image for gce on linux._

* [jeffs-ubuntu-2204-gce-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/google-compute-engine/jeffs-ubuntu-2204-gce-image)

  _Using packer to remotely build an ubuntu 22.04 gce image for gce on linux._

## VAGRANT IMAGES

* [jeffs-ubuntu-2204-vagrant-image-for-virtualbox-on-linux](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/vagrant/jeffs-ubuntu-2204-vagrant-image-for-virtualbox-on-linux)

  _Using packer to build an ubuntu 22.04 vagrant image for virtualbox on linux._

* [jeffs-ubuntu-2204-vagrant-image-for-virtualbox-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/windows/vagrant/jeffs-ubuntu-2204-vagrant-image-for-virtualbox-on-windows)

  _Using packer to build an ubuntu 22.04 vagrant image for virtualbox on windows._

## VIRTUALBOX IMAGES

* [jeffs-windows-11-virtualbox-image-for-virtualbox-on-linux](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/virtualbox/jeffs-windows-11-virtualbox-image-for-virtualbox-on-linux)

  _Using packer to build a windows 11 virtualbox image for virtualbox on linux._

* [jeffs-windows-11-virtualbox-image-for-virtualbox-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/windows/virtualbox/jeffs-windows-11-virtualbox-image-for-virtualbox-on-windows)

  _Using packer to build a windows 11 virtualbox image for virtualbox on windows._
