# jeffs-proxmox-image-ubuntu

[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)
[![MIT License](https://img.shields.io/:license-mit-blue.svg)](https://jeffdecola.mit-license.org)

_Using packer to remotely build a proxmox image
containing the ubuntu OS
for proxmox on linux._

Table on Contents

* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-ubuntu#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-ubuntu#build-image)
* [TEST IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-ubuntu#test-image)

Documentation and Reference

* [packer](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* [proxmox](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/other/stem/technology/computer-manufacturers/dell-poweredge-rack-servers/proxmox-install-configure-and-create-vm-cheat-sheet)
  * [configure proxmox for packer builds](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/other/stem/technology/computer-manufacturers/dell-poweredge-rack-servers/proxmox-install-configure-and-create-vm-cheat-sheet#configure-proxmox-for-packer-builds)

## PACKER TEMPLATE FILE

* PACKER FILE
  * [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-ubuntu/template.pkr.hcl)
* HARDWARE
  * CPU: 2 Cores
  * RAM: 2GB
  * Disk Size: 30 GB
* USER SETUP
  * [add-user-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/add-user-jeff.sh)
* SECURITY (SSH KEYS)
  * [add-proxmox-universal-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/add-proxmox-universal-ssh-keys-to-jeff.sh)
  * [add-github-ssh-keys-to-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/add-github-ssh-keys-to-root.sh)
  * [add-github-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/add-github-ssh-keys-to-jeff.sh)
* PROVISIONING (SYSTEM LEVEL)
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/update-upgrade-system.sh)
    (option to turn off periodic updates and auto-upgrades)
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/install-packages.sh)
    (htop, tmux, unzip, etc.)
  * [install-docker.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/install-docker.sh)
  * [run-dockerhub-image-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/run-dockerhub-image-at-boot.sh)
  * [install-go-and-config-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/install-go-and-config-for-root.sh)
  * [install-protocol-buffers-for-go.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/install-protocol-buffers-for-go.sh)
* CONFIGURE (USER LEVEL)
  * [move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/move-welcome-file-to-jeff.sh)
    (Move
    [welcome.txt](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-files/welcome.txt)
    file to /home/jeff)
  * [edit-bashrc-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/edit-bashrc-for-root.sh)
  * [edit-bashrc-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/edit-bashrc-for-jeff.sh)
  * [add-colors-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/add-colors-for-jeff.sh)
  * [config-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/config-go-for-jeff.sh)
  * [clone-git-aware-prompt-for-jeff](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/clone-git-aware-prompt-for-jeff.sh)
  * [add-vscode-settings-json-file.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/add-vscode-settings-json-file.sh)
    (Move settings.json in ~/.vscode-server/data/Machine for vs code remote connection)
  * [pull-private-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/pull-private-repos-for-jeff.sh)
* SERVICES
  * [service-install.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/service-install.sh)
    (Create executable /root/bin/hello-go)
  * [service-enable-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/service-enable-at-boot.sh)
* CLEANUP
  * [remove-github-ssh-keys.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/remove-github-ssh-keys.sh)
* APPS
  * docker: ???
  * go: ????
  * protoc: ?????
* SERVICES
  * [hello-go-deploy-gce](https://hub.docker.com/r/jeffdecola/hello-go-deploy-gce)
    dockerhub image runs at boot
  * A binary /usr/bin/hello-go executable runs at boot

## BUILD IMAGE

You will need to set the following environment variables (I added mine in ~/.bash-secrets and source in ~/.bashrc),

```txt
PROXMOX_TOKEN_ID=packer@pam!mytoken
PROXMOX_TOKEN_SECRET=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

To validate your packer template file,

```bash
packer validate \
    -var "image_name=proxmox-image-ubuntu" \
    -var "proxmox_token_id=$PROXMOX_TOKEN_ID" \
    -var "proxmox_token_secret=$PROXMOX_TOKEN_SECRET" \
    template.pkr.hcl
```

To
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-ubuntu/build-image.sh)
on proxmox,

```bash
packer build \
    -var "image_name=proxmox-image-ubuntu" \
    -var "proxmox_token_id=$PROXMOX_TOKEN_ID" \
    -var "proxmox_token_secret=$PROXMOX_TOKEN_SECRET" \
    template.pkr.hcl
```

Check that the image was created at proxmox,

```bash
qmlist
```

## TEST IMAGE

The image is located.
