  _built with
  [concourse](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/ci-README.md)_

# OVERVIEW

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

* [jeffs-ubuntu-1904-gce-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image)

  _Using packer to remotely build an ubuntu 19.04 gce image for gce on linux._

* [jeffs-ubuntu-2004-gce-image](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-2004-gce-image)

  _Using packer to remotely build an ubuntu 20.04 gce image for gce on linux._

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
