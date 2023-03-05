# jeffs-docker-image-ubuntu-2204

[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

_Using packer to build a docker image
containing the ubuntu 22.04 OS
for docker on linux._

Table of Contents

* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-ubuntu-2204#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-ubuntu-2204#build-image)
* [TEST IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-ubuntu-2204#test-image)

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* My
  [docker cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/docker-cheat-sheet)

## PACKER TEMPLATE FILE

* Packer file:
  [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-ubuntu-2204/template.pkr.hcl)
* Size: ~260MB
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-ubuntu-2204/install-scripts/update-upgrade-system.sh)
    Update & upgrade
  * [move-welcome-file-to-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-ubuntu-2204/install-scripts/move-welcome-file-to-root.sh)
    Move welcome.txt to /root
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-ubuntu-2204/install-scripts/install-packages.sh)
    Install packages bash and htop  
* Source Image: docker
  * **"ubuntu:jammy"** for docker on linux
* Custom Image: docker
  * ubuntu 22.04 for docker on linux

## BUILD IMAGE

Validate and build on docker,

```bash
packer validate template.pkr.hcl
packer build template.pkr.hcl
```

Or use
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-docker-image-ubuntu-2204/build-image.sh),

```bash
sh build-image.sh
```

## TEST IMAGE

Deploy and connect to the image,

```bash
docker run --name jeffs-docker-image-ubuntu-2204 -dit jeffdecola/my-packer-image-builds/jeffs-docker-image-ubuntu-2204
docker exec -i -t jeffs-docker-image-ubuntu-2204 /bin/bash
cat /etc/os-release
```
