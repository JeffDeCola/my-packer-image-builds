# jeffs-docker-image-alpine

[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

_Using packer to build a docker image
containing the alpine OS
for docker on linux._

Table of Contents

* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-alpine#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-alpine#build-image)
* [TEST IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-alpine#test-image)

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* My
  [docker cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/docker-cheat-sheet)

## PACKER TEMPLATE FILE

* _Using packer to build a docker image
  containing the alpine OS
  for docker on linux_
* Packer file:
  [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-alpine/template.pkr.hcl)
* Size: ~260MB
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-alpine/install-scripts/update-upgrade-system.sh)
    Update & upgrade
  * [move-welcome-file-to-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-alpine/install-scripts/move-welcome-file-to-root.sh)
    Move welcome.txt to /root
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-alpine/install-scripts/install-packages.sh)
    Install packages bash and htop  
* Source Image: docker
  * **"golang:alpine"** for docker on linux
* Custom Image: docker
  * alpine 3.17.2 for docker on linux
* Contains:
  * go: 1.20.1

## BUILD IMAGE

Validate and build on docker,

```bash
packer validate template.pkr.hcl
packer build template.pkr.hcl
```

Or use
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-alpine/build-image.sh),

```bash
sh build-image.sh
```

## TEST IMAGE

Deploy and connect to the image,

```bash
docker run --name jeffs-docker-image-alpine -dit jeffdecola/my-packer-image-builds/jeffs-docker-image-alpine
docker exec -i -t jeffs-docker-image-alpine /bin/bash
go version
cat /etc/os-release
```
