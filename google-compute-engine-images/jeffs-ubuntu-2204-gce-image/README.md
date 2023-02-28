# jeffs-gce-ubuntu-2004

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

* _Using packer to remotely build an ubuntu 19.04 gce image for gce on linux._
* Packer File:
  [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-ubuntu-2204-gce-image/template.pkr.hcl)
* Size: ~????MB
* Zone: us-east1
* Machine type: e2-micro
* Disk: 30 GB Standard Persistent Disk
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
    Place vs code settings.json in ~/.vscode-server/data/Machine for remote conn
  * [install-protocol-buffers-for-go.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/install-scripts/install-protocol-buffers-for-go.sh)
    Install protoc and the go binary protoc-gen-go
* This gce image contains the following, with these versions or higher
  * gce base image: ubuntu-2004-focal-v20220110 (gce base image)
  * custom image OS: ubuntu 22.04
  * go: ????

## BUILD IMAGE

You will need to set the following environment variables,

```bash
export GCP_JEFFS_SERVICE_ACCOUNT_PATH=[path to your google platform .json file]
export GCP_JEFFS_PROJECT_ID=[your project id]
```

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

We will use the
[free tier](https://cloud.google.com/free/docs/gcp-free-tier/?hl=en_US#compute)
to deploy to,

* e2-micro (2 vCPU, 1 GB memory)
* us-east1 (South Carolina)
* 30 GB Standard Persistent Disk
* 5GB snapshot storage (us-east1 South Carolina)
* 1GB network Egress
* Free External IP

We will run
[create-firewall-rule.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/create-firewall-rule.sh),
[create-instance-template.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/build-image.sh)
and
[create-instance-group.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine/jeffs-gce-ubuntu-2004/create-instance-group.sh).

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
ssh -i ~/.ssh/gce_universal_id_rsa <USERNAME>@<HOSTNAME/INSTANCE_NAME>.us-east1-a.c.<PROJECT>.internal
```
