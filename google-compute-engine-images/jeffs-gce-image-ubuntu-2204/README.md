# jeffs-gce-image-ubuntu-2204

[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

_Using packer to remotely build a gce image
containing the ubuntu 22.04 OS
for gce on linux._

Table on Contents

* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204#build-image)
* [TEST IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204#test-image)

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* My
  [gce cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/service-architectures/infrastructure-as-a-service/google-compute-engine-cheat-sheet)

## PACKER TEMPLATE FILE

* _Using packer to remotely build a gce image
  containing the ubuntu 22.04 OS
  for gce on linux_
* Packer file:
  [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/template.pkr.hcl)
* Size: 30 GB Standard Persistent Disk
* Region: us-east1
* Machine type: e2-micro (2 vCPU, 1 GB memory)
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/update-upgrade-system.sh)
    Update & upgrade (option to turn off periodic updates and auto-upgrades)
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/install-packages.sh)
    Install packages like htop, tmux, unzip, etc.
  * [add-user-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/add-user-jeff.sh)
    Add user jeff
  * [move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/move-welcome-file-to-jeff.sh)
    Move welcome.txt file to /home/jeff
  * [edit-bashrc-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/edit-bashrc-for-root.sh)
    Edit .bashrc for user root
  * [edit-bashrc-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/edit-bashrc-for-jeff.sh)
    Edit .bashrc for user jeff
  * [add-colors-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/add-colors-for-jeff.sh)
    Add colors for user jeff
  * [add-gce-universal-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/add-gce-universal-ssh-keys-to-jeff.sh)
    Add a universal key so VMs can ssh into each other
  * [add-github-ssh-keys-to-root-and-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/add-github-ssh-keys-to-root.sh)
    Add github keys for user root
  * [add-github-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/add-github-ssh-keys-to-jeff.sh)
    Add github keys for user jeff
  * [install-docker.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/install-docker.sh)
    Install docker
  * [install-go-and-config-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/install-go-and-config-for-root.sh)
    Install go and config for user root
  * [config-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/config-go-for-jeff.sh)
    Config go for user jeff
  * [install-protocol-buffers-for-go.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/install-protocol-buffers-for-go.sh)
    Install protoc and the go binary protoc-gen-go
  * [clone-git-aware-prompt-for-jeff](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/clone-git-aware-prompt-for-jeff.sh)
    Clone git-aware-prompt for user jeff
  * [add-vscode-settings-json-file.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/add-vscode-settings-json-file.sh)
    Move settings.json in ~/.vscode-server/data/Machine for vs code remote connection
  * [pull-private-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/pull-private-repos-for-jeff.sh)
    Pull some of my repos for jeff
* Source Image: gce
  * **"ubuntu-2204-jammy-v20230214"** for gce on linux
* Custom Image: gce
  * ubuntu 22.04 for gce on linux
* Contains:
  * docker: 23.0.1
  * go: 1.20.1
  * protoc: 3.12.4

## BUILD IMAGE

You will need to set the following environment variables (I added mine in ~/.bashrc),

```bash
export GCP_JEFFS_SERVICE_ACCOUNT_PATH=[path to your google platform .json file]
export GCP_JEFFS_PROJECT_ID=[your project id]
```

Validate and build at gce,

```bash
packer validate \
    -var "account_file=$GCP_JEFFS_SERVICE_ACCOUNT_PATH" \
    -var "project_id=$GCP_JEFFS_PROJECT_ID" \
    template.pkr.hcl
packer build \
    -var "account_file=$GCP_JEFFS_SERVICE_ACCOUNT_PATH" \
    -var "project_id=$GCP_JEFFS_PROJECT_ID" \
    template.pkr.hcl
```

Or use
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/build-image.sh),

```bash
sh build-image.sh
```

## TEST IMAGE

This image uses the gce
[free tier](https://cloud.google.com/free/docs/gcp-free-tier/?hl=en_US#compute),

* Machine: e2-micro (2 vCPU, 1 GB memory)
* Region: us-east1 (South Carolina)
* Disk: 30 GB Standard Persistent Disk
* Snapshot Storage: 5GB
* Network Egress: 1GB
* Free External IP

To deploy VM on gce I use [create-firewall-rule.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/create-firewall-rule.sh),
[create-instance-template.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/create-instance-template.sh)
and
[create-instance-group.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/create-instance-group.sh).

You only need to run this once,

```bash
sh create-firewall-rule.sh
```

Create your template and group,

```bash
sh create-instance-template.sh
sh create-instance-group.sh
```

To ssh into your gce vm,

```bash
ssh -i ~/.ssh/google_compute_engine jeff@<IP>
docker version
go version
protoc --version
```

You may also ssh from VM to VM using gce's internal DNS,

```bash
ssh -i ~/.ssh/gce_universal_id_rsa <USERNAME>@<HOSTNAME/INSTANCE_NAME>.us-east1-a.c.<PROJECT>.internal
```
