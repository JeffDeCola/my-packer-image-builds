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
  * [FIREWALL RULE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204#firewall-rule)
  * [CREATE INSTANCE TEMPLATE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204#create-instance-template)
  * [CREATE INSTANCE GROUP](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204#create-instance-group)
  * [SSH INTO VM](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204#ssh-into-vm)

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* My
  [gce cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/service-architectures/infrastructure-as-a-service/google-compute-engine-cheat-sheet)

## PACKER TEMPLATE FILE

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
  * [add-github-ssh-keys-to-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/add-github-ssh-keys-to-root.sh)
    Add github keys for user root
  * [add-github-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/add-github-ssh-keys-to-jeff.sh)
    Add github keys for user jeff
  * [install-docker.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/install-docker.sh)
    Install docker
  * [run-dockerhub-image-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/run-dockerhub-image-at-boot.sh)
    Run dockerhub image at boot
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
  * [service-install.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/service-install.sh)
    Create executable /root/bin/hello-go
  * [service-enable-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/service-enable-at-boot.sh)
    Run executable (service) at boot
  * [remove-github-ssh-keys.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/install-scripts/remove-github-ssh-keys.sh)
    For security, remove the github keys
* Source Image: gce
  * **"ubuntu-2204-jammy-v20230214"** for gce on linux
* Custom Image: gce
  * ubuntu 22.04 for gce on linux
* Contains:
  * docker: 23.0.1
  * go: 1.20.1
  * protoc: 3.12.4
  * [hello-go-deploy-gce dockerhub image](https://hub.docker.com/r/jeffdecola/hello-go-deploy-gce)
    runs at boot
  * A binary /usr/bin/hello-go executable runs at boot

## BUILD IMAGE

You will need to set the following environment variables (I added mine in ~/.bashrc),

```bash
export GCP_JEFFS_SERVICE_ACCOUNT_PATH=[path to your google platform .json file]
export GCP_JEFFS_PROJECT_ID=[your project id]
```

Will be building image using,

* Machine: e2-standard-2 (2 vCPU, 8 GB memory)
* Region: us-east4 (Northern Virginia)
* Zone: us-east4-c
* Disk: 30 GB Standard Persistent Disk

To validate your packer file,

```bash
packer validate \
    -var "image_name=gce-ubuntu-2204" \
    -var "account_file=$GCP_JEFFS_SERVICE_ACCOUNT_PATH" \
    -var "project_id=$GCP_JEFFS_PROJECT_ID" \
    template.pkr.hcl
```

To
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/build-image.sh)
on gce,

```bash
packer build \
    -var "image_name=gce-ubuntu-2204" \
    -var "account_file=$GCP_JEFFS_SERVICE_ACCOUNT_PATH" \
    -var "project_id=$GCP_JEFFS_PROJECT_ID" \
    template.pkr.hcl
```

Check that the image was created at gce,

```bash
gcloud config set project $GCP_JEFFS_PROJECT_ID
gcloud compute images list --no-standard-images
```

## TEST IMAGE

This image uses the gce
[free tier](https://cloud.google.com/free/docs/gcp-free-tier/?hl=en_US#compute),

* Machine: e2-micro (.25-2 vCPU, 1 GB memory)
* Region: us-east1 (South Carolina)
* Disk: 30 GB Standard Persistent Disk
* Snapshot Storage: 5GB
* Network Egress: 1GB
* Free External IP

### FIREWALL RULE

You only need to
[create-firewall-rule.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/create-firewall-rule.sh)
once,

```bash
sh create-firewall-rule.sh
```

### CREATE INSTANCE TEMPLATE

To
[create-instance-template](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/create-instance-template.sh),

```bash
sh create-instance-template.sh "jeffs-gce-ubuntu-2204-image" "gce-ubuntu-2204"
```

Check the instance template was created,

```bash
gcloud compute instance-templates list
```

### CREATE INSTANCE GROUP

To
[create-instance-group](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/google-compute-engine-images/jeffs-gce-image-ubuntu-2204/create-instance-group.sh),

```bash
sh create-instance-group.sh "jeffs-gce-ubuntu-2204-instance-template" "gce-ubuntu-2204"
```

Check that the instance group and VM instance were created,

```bash
gcloud compute instance-groups list
gcloud compute instances list
```

### SSH INTO VM

I placed my public keys in gce metadata ssh keys, which automatically
places them in the authorized_keys files on my VM

Hence, to ssh into your gce vm,

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
