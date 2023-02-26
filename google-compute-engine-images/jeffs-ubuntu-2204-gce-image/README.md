# jeffs-gce-ubuntu-2004-xxxx

_Using packer to build an ubuntu 20.04 image at google compute engine._

[GitHub Webpage](https://jeffdecola.github.io/my-packer-image-builds/)

## PACKER TEMPLATE FILE

The packer template file will build, configure and provision this image
from a base image.

* [gce-packer-template.json](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/gce-packer-template.json)
* Using gce resources for build
  * ubuntu-2004-focal-v20220110 (gce base image)
  * us-west1
  * e2-micro, 30 GB Standard Persistent Disk
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/update-upgrade-system.sh)
    Update & upgrade, turn off periodic updates and auto-upgrades
  * [add-user-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/add-user-jeff.sh)
    Add user jeff
  * [edit-bashrc-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/edit-bashrc-for-jeff.sh)
    Add git-aware prompt.
  * [move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/move-welcome-file-to-jeff.sh)
    Test to add file to /home/jeff
  * [add-gce-universal-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/add-gce-universal-ssh-keys-to-jeff.sh)
    Add a universal key so VMs can ssh into each other
  * [add-github-ssh-keys-to-root-and-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/add-github-ssh-keys-to-root.sh)
    Add keys for github to root
  * [add-github-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/add-github-ssh-keys-to-jeff.sh)
    Add keys for github to jeff
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/install-packages.sh)
    Install packages like htop, tmux, unzip, etc...
  * [install-docker.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/install-docker.sh)
    Install docker
  * [install-go-and-config-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/install-go-and-config-for-root.sh)
    Install go and config for user root
  * [config-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/config-go-for-jeff.sh)
    Config go for user jeff
  * [pull-private-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/pull-private-repos-for-jeff.sh)
    Pull my-global-repo-scripts-private and then pull all repos (not keybase one)
  * [add-vscode-settings-json-file.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/add-vscode-settings-json-file.sh)
    Place VS Code settings.json file in ~/.vscode-server/data/Machine for remote connection
  * [install-protocol-buffers-for-go.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/install-protocol-buffers-for-go.sh)
    Install protoc and the go binary protoc-gen-go

## BUILD

To build use
[build.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/build-image.sh),

```bash
sh build.sh
```

To deploy with,

* e2-micro (2 vCPU, 1 GB memory)
* us-west1 (Oregon)
* 30 GB Standard Persistent Disk
* 5GB snapshot storage (us-west1 Oregon)
* 1GB network Egress
* Free External IP

From the
[Free Tier](https://cloud.google.com/free/docs/gcp-free-tier/?hl=en_US#compute).

## CONNECT

Use
[create-firewall-rule.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/create-firewall-rule.sh),
[create-instance-template.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/build-image.sh)
and
[create-instance-group.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/create-instance-group.sh),

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