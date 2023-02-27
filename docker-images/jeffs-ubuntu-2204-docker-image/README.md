# jeffs-ubuntu-2202-docker-image

[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

  _Using packer to build an alpine docker image for docker on linux._

Table of Contents

* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-ubuntu-2202-docker-image#packer-template-file)
* [BUILD](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-ubuntu-2202-docker-image#build)
* [DEPLOY](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-ubuntu-2202-docker-image#deploy)

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* My
  [docker cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/docker-cheat-sheet)

## PACKER TEMPLATE FILE

The
[template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-ubuntu-2202-docker-image/template.pkr.hcl)
will build,

* Docker Image on linux
  * OS: ubuntu:jammy
    * jammy: 22.04
  * Size: ~128MB
  * Configure and provision
    * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-ubuntu-2204-docker-image/install-scripts/update-upgrade-system.sh)
    Update & upgrade
    * [move-welcome-file-to-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-ubuntu-2204-docker-image/install-scripts/move-welcome-file-to-root.sh)
    Move welcome.txt to /root
    * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-ubuntu-2204-docker-image/install-scripts/install-packages.sh)
    Install packages htop

## BUILD

```bash
packer validate template.pkr.hcl
packer build template.pkr.hcl
```

Or use
[build.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-ubuntu-2202-docker-imagebuild-image.sh),

```bash
sh build.sh
```

## DEPLOY

Deploy and connect to the image,

```bash
docker run --name jeffs-ubuntu-2202-docker-image -dit jeffdecola/my-packer-image-builds/jeffs-ubuntu-2202-docker-image
docker exec -i -t jeffs-ubuntu-2202-docker-image /bin/bash
cat /etc/os-release
```
