# jeffs-ubuntu-2204-gce-image

_Using packer to remotely build an ubuntu 22.04 gce image for gce on linux._

Table on Contents

* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image#build-image)
* [TEST IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image#test-image)

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* My
  [gce cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/service-architectures/infrastructure-as-a-service/google-compute-engine-cheat-sheet)

## PACKER TEMPLATE FILE

* _Using packer to remotely build an ubuntu 22.04 gce image for gce on linux._
* Packer File:
  [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/template.pkr.hcl)
* Region: us-east1
* Machine type: e2-micro (2 vCPU, 1 GB memory)
* Disk: 30 GB Standard Persistent Disk
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/update-upgrade-system.sh)
    Update & upgrade, turn off periodic updates and auto-upgrades
  * [add-user-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/add-user-jeff.sh)
    Add user jeff
  * [edit-bashrc-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/edit-bashrc-for-root.sh)
    Edit .bashrc for user root
  * [add-colors-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/add-colors-for-jeff.sh)
    Add colors for user jeff
  * [edit-bashrc-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/edit-bashrc-for-jeff.sh)
    Edit .bashrc for user jeff
  * [move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/move-welcome-file-to-jeff.sh)
    Move welcome.txt file to /home/jeff
  * [add-gce-universal-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/add-gce-universal-ssh-keys-to-jeff.sh)
    Add a universal key so VMs can ssh into each other
  * [add-github-ssh-keys-to-root-and-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/add-github-ssh-keys-to-root.sh)
    Add github keys for user root
  * [add-github-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/add-github-ssh-keys-to-jeff.sh)
    Add github keys for user jeff
  * [clone-git-aware-prompt-for-jeff](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/clone-git-aware-prompt-for-jeff.sh)
    Clone git-aware-prompt for user jeff
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/install-packages.sh)
    Install packages like htop, tmux, unzip, etc.
  * [install-docker.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/install-docker.sh)
    Install docker
  * [install-go-and-config-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/install-go-and-config-for-root.sh)
    Install go and config for user root
  * [config-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/config-go-for-jeff.sh)
    Config go for user jeff
  * [pull-private-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/pull-private-repos-for-jeff.sh)
    Pull my-global-repo-scripts-private and then pull all repos
  * [add-vscode-settings-json-file.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/add-vscode-settings-json-file.sh)
    Move settings.json in ~/.vscode-server/data/Machine for vs code remote connection
  * [install-protocol-buffers-for-go.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/install-scripts/install-protocol-buffers-for-go.sh)
    Install protoc and the go binary protoc-gen-go
* This gce image contains the following, with these versions or higher
  * gce base image: ubuntu-2204-jammy-v20230214
  * custom image OS: ubuntu 22.04
  * go: 1.20.1????
  * docker: 20.10.7????

## BUILD IMAGE

You will need to set the following environment variables (I added mine in ~/.bashrc),

```bash
export GCP_JEFFS_SERVICE_ACCOUNT_PATH=[path to your google platform .json file]
export GCP_JEFFS_PROJECT_ID=[your project id]
```

Validate and build,

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
[build.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/build-image.sh),

```bash
sh build.sh
```

## TEST IMAGE

This image uses the
[free tier](https://cloud.google.com/free/docs/gcp-free-tier/?hl=en_US#compute),

* Machine: e2-micro (2 vCPU, 1 GB memory)
* Region: us-east1 (South Carolina)
* Disk: 30 GB Standard Persistent Disk
* Snapshot Storage: 5GB
* Network Egress: 1GB
* Free External IP

To deploy VM on gce I use [create-firewall-rule.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/create-firewall-rule.sh),
[create-instance-template.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/build-image.sh)
and
[create-instance-group.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/create-instance-group.sh).

```bash
sh create-firewall-rule.sh
sh create-instance-template.sh
sh create-instance-group.sh
```

To ssh into your gce vm,

```bash
ssh -i ~/.ssh/google_compute_engine jeff@<IP>
```

You may also ssh from VM to VM using gce's internal DNS,

```bash
ssh -i ~/.ssh/gce_universal_id_rsa <USERNAME>@<HOSTNAME/INSTANCE_NAME>.us-east1-a.c.<PROJECT>.internal
```
