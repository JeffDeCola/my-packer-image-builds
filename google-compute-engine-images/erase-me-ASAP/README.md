# jeffs-ubuntu-1904-gce-image

_Using packer to remotely build an ubuntu 19.04 gce image for gce on linux._

Table on Contents

* tbd

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* My
  [gce cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/service-architectures/infrastructure-as-a-service/google-compute-engine-cheat-sheet)

## PACKER TEMPLATE FILE

* _Using packer to remotely build an ubuntu 19.04 gce image for gce on linux._
* Packer File:
  [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/template.pkr.hcl)
* Size: ~????MB
* Zone: us-west1-a
* Machine type: n1-standard-1
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/update-upgrade-system.sh)
    Update & upgrade, turn off periodic updates and auto-upgrades
  * [add-user-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/add-user-jeff.sh)
    Add user jeff
  * [edit-bashrc-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/edit-bashrc-for-jeff.sh)
    Add git-aware prompt.
  * [move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/move-welcome-file-to-jeff.sh)
    Test to add file to /home/jeff
  * [add-gce-universal-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/add-gce-universal-ssh-keys-to-jeff.sh)
    Add a universal key so VMs can ssh into each other
  * [add-github-ssh-keys-to-root-and-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/add-github-ssh-keys-to-root.sh)
    Add keys for github to root
  * [add-github-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/add-github-ssh-keys-to-jeff.sh)
    Add keys for github to jeff
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/install-packages.sh)
    Install packages like htop, tmux, unzip, etc...
  * [install-docker.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/install-docker.sh)
    Install docker
  * [install-go-and-config-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/install-go-and-config-for-root.sh)
    Install go and config for user root
  * [config-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/config-go-for-jeff.sh)
    Config go for user jeff
  * [pull-private-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/install-scripts/pull-private-repos-for-jeff.sh)
    Pull my-global-repo-scripts-private and then pull all repos (not keybase one)
* This gce image contains the following, with these versions or higher
  * Base OS: ubuntu-1904-disco-v20190724
  * Image OS: ubuntu 19.04
  * go: 1.20.1 ????

## BUILD IMAGE

```bash
packer validate template.pkr.hcl
packer build template.pkr.hcl
```

Or use
[build.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-imagebuild-image.sh),

```bash
sh build.sh
```

## TEST IMAGE

Deploy and connect to the image,

```bash
docker run --name jeffs-ubuntu-1904-gce-image -dit jeffdecola/my-packer-image-builds/jeffs-ubuntu-1904-gce-image
docker exec -i -t jeffs-ubuntu-1904-gce-image /bin/bash
go version
cat /etc/os-release
```







## PACKER TEMPLATE FILE



## BUILD

To build use
[build.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/build-image.sh),

```bash
sh build.sh
```

To deploy with,

* f1-micro
* us-west1

## CONNECT

Use
[create-firewall-rule.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/create-firewall-rule.sh),
[create-instance-template.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/build-image.sh)
and
[create-instance-group.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-1904-gce-image/create-instance-group.sh),

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
