# jeffs-alpine-docker-image

[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

  _Using packer to build an alpine docker image for docker on linux._

Table of Contents

* tbd

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* My
  [docker cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/docker-cheat-sheet)

## PACKER TEMPLATE FILE

The
[template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-alpine-docker-image/template.pkr.hcl)
will build,

* Docker image
  * OS: golang:alpine
  * Size: ~250MB
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-alpine-docker-imageinstall-scripts/update-upgrade-system.sh)
    Update & upgrade
  * [move-welcome-file-to-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-alpine-docker-imageinstall-scripts/move-welcome-file-to-root.sh)
    Move welcome.txt to /root
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-alpine-docker-imageinstall-scripts/install-packages.sh)
    Install packages bash and htop

## BUILD

```bash
packer validate template.pkr.hcl
packer build template.pkr.hcl
```

Or use
[build.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/docker-images/jeffs-alpine-docker-imagebuild-image.sh),

```bash
sh build.sh
```

## DEPLOY

Deploy and connect to the image,

```bash
docker run --name jeffs-alpine-docker-image -dit jeffdecola/my-packer-image-builds/jeffs-alpine-docker-image
docker exec -i -t jeffs-alpine-docker-image /bin/bash
cat /etc/os-release
```
