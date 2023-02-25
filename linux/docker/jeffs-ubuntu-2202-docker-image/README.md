# jeffs-ubuntu-2202-docker-image

[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)


 _Using packer to build an ubuntu 22.04 docker image on linux._

[GitHub Webpage](https://jeffdecola.github.io/my-packer-image-builds/)

## PACKER TEMPLATE FILE

The packer template file will build, configure and provision this image
from a base image.

* [gce-packer-template.json](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/gce-packer-template.json)
* Using gce resources for build
  * ubuntu-1904-disco-v20190724 (gce base image)
  * us-west1-a
  * n1-standard-1
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/update-upgrade-system.sh)
  Update & upgrade, turn off periodic updates and auto-upgrades
  * [add-user-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/add-user-jeff.sh)
  Add user jeff
  * [edit-bashrc-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/edit-bashrc-for-jeff.sh)
  Add git-aware prompt.
  * [move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/move-welcome-file-to-jeff.sh)
  Test to add file to /home/jeff
  * [add-gce-universal-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/add-gce-universal-ssh-keys-to-jeff.sh)
  Add a universal key so VMs can ssh into each other
  * [add-github-ssh-keys-to-root-and-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/add-github-ssh-keys-to-root.sh)
  Add keys for github to root
  * [add-github-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/add-github-ssh-keys-to-jeff.sh)
  Add keys for github to jeff
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/install-packages.sh)
  Install packages like htop, tmux, unzip, etc...
  * [install-docker.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/install-docker.sh)
  Install docker
  * [install-go-and-config-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/install-go-and-config-for-root.sh)
  Install go and config for user root
  * [config-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/config-go-for-jeff.sh)
  Config go for user jeff
  * [pull-private-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/install-scripts/pull-private-repos-for-jeff.sh)
  Pull my-global-repo-scripts-private and then pull all repos (not keybase one)

## BUILD

To build use
[build.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/build-image.sh),

```bash
sh build.sh
```

To deploy with,

* f1-micro
* us-west1

## CONNECT

Use
[create-firewall-rule.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/create-firewall-rule.sh),
[create-instance-template.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/build-image.sh)
and
[create-instance-group.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-1904/create-instance-group.sh),

```bash
sh create-firewall-rule.sh
sh create-instance-template.sh
sh create-instance-group.sh
```

ssh into your machine,

```bash
ssh -i ~/.ssh/google_compute_engine jeff@<IP>
```

You can also ssh from VM to VM using gce's internal DNS,

```bash
ssh -i ~/.ssh/gce_universal_id_rsa <USERNAME>@<HOSTNAME/INSTANCE_NAME>.us-west1-a.c.<PROJECT>.internal
```
