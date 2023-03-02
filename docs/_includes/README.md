  _built with
  [concourse](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/ci-README.md)_

# OVERVIEW

These builds use the following statement,

**Using packer to build a/an {CUSTOM IMAGE FILE} image
containing the {CUSTOM IMAGE OS} OS
for {PLATFORM TOOL} on {HOST OS}.**

Where,

* **CUSTOM IMAGE FILE**: docker/gce/vagrant/virtualbox
* **CUSTOM IMAGE OS**: ubuntu/alpine/windows
* **PLATFORM TOOL**: docker/gce/virtualbox
* **HOST OS**: linux/windows

## DOCKER IMAGES

_You can also build docker images using a dockerfile as shown in
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

## VAGRANT IMAGES

* [jeffs-vagrant-image-ubuntu-2204-for-virtualbox-on-linux](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox-on-linux)

  _Using packer to build a vagrant image (box)
  containing the ubuntu 22.04 OS
  for virtualbox on linux._

* [jeffs-vagrant-image-ubuntu-2204-for-virtualbox-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox-on-windows)

  _Using packer to build a vagrant image (box)
  containing the ubuntu 22.04 OS
  for virtualbox on windows._

* [jeffs-vagrant-image-windows-11-for-virtualbox-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-windows-11-for-virtualbox-on-windows)

  _Using packer to build a vagrant image (box)
  containing the windows 11 OS
  for virtualbox on windows._

## VIRTUALBOX IMAGES

* [jeffs-virtualbox-image-ubuntu-2204-for-virtualbox-on-linux](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox-on-linux)

  _Using packer to build a virtualbox image
  containing the ubuntu 22.04 OS
  for virtualbox on linux._

* [jeffs-virtualbox-image-ubuntu-2204-for-virtualbox-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox-on-windows)

  _Using packer to build a virtualbox image
  containing the ubuntu 22.04 OS
  for virtualbox on windows._

* [jeffs-virtualbox-image-windows-11-for-virtualbox-on-windows](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-windows-11-for-virtualbox-on-windows)

  _Using packer to build a virtualbox image
  containing the windows 11 OS
  for virtualbox on windows._
