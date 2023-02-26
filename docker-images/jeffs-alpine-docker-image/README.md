# jeffs-alpine-docker-image

[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

  _Using packer to build an alpine docker image for docker on linux._

[GitHub Webpage](https://jeffdecola.github.io/my-packer-image-builds/)

Table of Contents

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* My
  [docker cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/docker-cheat-sheet)

## PACKER TEMPLATE FILE

The packer template file will build, configure and provision this image
from a base image.

* [template.json](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/gce-packer-template.json)
* Using docker resources for build
  * alpine(??? base image)
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/update-upgrade-system.sh)
  Update & upgrade, turn off periodic updates and auto-upgrades
  * [add-user-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/add-user-jeff.sh)
  Add user jeff
  * [move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/move-welcome-file-to-jeff.sh)
  Test to add file to /home/jeff
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/install-packages.sh)
  Install packages like htop, tmux, unzip, etc...

## BUILD

To build use
[build.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/build-image.sh),

```bash
sh build.sh
```

## CONNECT
