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

* [LINUX](https://github.com/JeffDeCola/my-packer-image-builds#linux)
  * [DOCKER](https://github.com/JeffDeCola/my-packer-image-builds#docker)
  * [GOOGLE COMPUTE ENGINE (GCE)](https://github.com/JeffDeCola/my-packer-image-builds#google-compute-engine-gce)
  * [VAGRANT](https://github.com/JeffDeCola/my-packer-image-builds#vagrant)
* [WINDOWS](https://github.com/JeffDeCola/my-packer-image-builds#windows)
  * [VAGRANT](https://github.com/JeffDeCola/my-packer-image-builds#vagrant)

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* This repos
  [github webpage](https://jeffdecola.github.io/my-packer-image-builds/)
  _built with
  [concourse](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/ci-README.md)_

## LINUX

### DOCKER

* [jeffs-ubuntu-2202-docker-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/docker/jeffs-ubuntu-2202-docker-image)

  _Using packer to build an ubuntu 22.04 docker image on linux._

### GOOGLE COMPUTE ENGINE (GCE)

* [jeffs-ubuntu-1904-gce-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/google-compute-engine/jeffs-ubuntu-1904-gce-image)

  _Using packer to remotely build an ubuntu 19.04 gce image on linux._

* [jeffs-ubuntu-2004-gce-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/google-compute-engine/jeffs-ubuntu-2004-gce-image4)

  _Using packer to remotely build an ubuntu 20.04 gce image on linux._

* [jeffs-ubuntu-2204-gce-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/google-compute-engine/jeffs-ubuntu-2204-gce-image)

  _Using packer to remotely build an ubuntu 22.04 gce image on linux._

### VAGRANT

* [jeffs-ubuntu-2204-vagrant-image-for-virtualbox-linux](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/linux/vagrant/jeffs-ubuntu-2204-vagrant-image-for-virtualbox-linux)

  _Using packer to build an ubuntu 22.04 vagrant image for virtualbox on linux._

## WINDOWS

### VAGRANT

* [jeffs-ubuntu-2204-vagrant-image-for-virtualbox-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/windows/vagrant/jeffs-ubuntu-2204-vagrant-image-for-virtualbox-windows)

  _Using packer to build an ubuntu 22.04 vagrant image for virtualbox on windows._
