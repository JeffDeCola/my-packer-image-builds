# jeffs-proxmox-image-ubuntu

[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)
[![MIT License](https://img.shields.io/:license-mit-blue.svg)](https://jeffdecola.mit-license.org)

_Using packer to remotely build a proxmox image
containing the ubuntu OS
for proxmox on linux._

Table on Contents

* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-ubuntu#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-ubuntu#build-image)
* [CLONE IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-ubuntu#clone-image)

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
  * [user-setup-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/user-setup-jeff.sh)
* SECURITY (SSH KEYS)
  * [security-prepend-proxmox-universal-key-to-authorized-keys-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/security-prepend-proxmox-universal-key-to-authorized-keys-jeff.sh)
  * [security-move-packer-github-temp-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/security-move-packer-github-temp-keys-to-jeff.sh)
* PROVISIONING (SYSTEM LEVEL)
  * [provisioning-update-upgrade.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/provisioning-update-upgrade.sh)
  * [provisioning-install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/provisioning-install-packages.sh)
  * [provisioning-install-docker.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/provisioning-install-docker.sh)
  * [provisioning-run-a-dockerhub-image-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/provisioning-run-a-dockerhub-image-at-boot.sh)
  * [provisioning-install-go-and-configure-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/provisioning-install-go-and-configure-for-root.sh)
* CONFIGURE (USER LEVEL)
  * [configure-move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/configure-move-welcome-file-to-jeff.sh)
  * [configure-bashrc-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/configure-bashrc-for-root.sh)
  * [configure-bashrc-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/configure-bashrc-for-jeff.sh)
  * [configure-git-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/configure-git-for-jeff.sh)
  * [configure-dircolors-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/configure-dircolors-for-jeff.sh)
  * [configure-prompt-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/configure-prompt-for-jeff.sh)
  * [configure-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/configure-go-for-jeff.sh)
  * [configure-move-vscode-server-settings-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/configure-move-vscode-server-settings-file-to-jeff.sh)
  * [configure-pull-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/configure-pull-repos-for-jeff.sh)
* SERVICES
  * [services-install-hello-go.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/services-install-hello-go.sh)
  * [services-enable-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/services-enable-at-boot.sh)
* CLEANUP
  * [cleanup-packer-github-temp-keys.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-ubuntu/install-scripts/cleanup-packer-github-temp-keys.sh)
* APPS
  * docker: 29.4.2
  * go: 1.26.2
* SERVICES
  * [hello-go-deploy-gce](https://hub.docker.com/r/jeffdecola/hello-go-deploy-gce) dockerhub image runs at boot
  * /home/jeff/hello-go binary runs at boot

## BUILD IMAGE

You will need to set the following environment variables (I added mine in ~/.bashrx-secrets and source in ~/.bashrc),

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
qm list
```

## CLONE IMAGE

In Proxmox UI, clone VM 500 as a full clone.
Set cloud-init IP to `192.168.20.250/24`, gateway `192.168.20.1`, then boot.

SSH in as jeff,

```bash
ssh -i ~/.ssh/proxmox_universal jeff@192.168.20.250
```

Set a password for jeff (jeff has no password by default),

```bash
ssh -i ~/.ssh/id_rsa packer@192.168.20.250
sudo passwd jeff
```

View service output,

```bash
journalctl -u hello-go.service -f
docker logs hello-go-deploy-gce -f
```

Stop services,

```bash
sudo systemctl stop hello-go.service
sudo docker stop hello-go-deploy-gce
```

Permanently disable services at boot,

```bash
sudo systemctl disable hello-go.service
sudo docker stop hello-go-deploy-gce && sudo docker rm hello-go-deploy-gce
```
