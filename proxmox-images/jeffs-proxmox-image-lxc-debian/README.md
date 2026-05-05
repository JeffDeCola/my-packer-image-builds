# jeffs-proxmox-image-lxc-debian

[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)
[![MIT License](https://img.shields.io/:license-mit-blue.svg)](https://jeffdecola.mit-license.org)

_Using packer to remotely build a proxmox image
containing the debian OS
for proxmox container on linux._

Table on Contents

* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-lxc-debian#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-lxc-debian#build-image)
* [TEST IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-lxc-debian#test-image)

Documentation and Reference

* [packer](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* [proxmox](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/other/stem/technology/computer-manufacturers/dell-poweredge-rack-servers/proxmox-install-configure-and-create-vm-cheat-sheet)
  * [configure proxmox for packer builds](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/other/stem/technology/computer-manufacturers/dell-poweredge-rack-servers/proxmox-install-configure-and-create-vm-cheat-sheet#configure-proxmox-for-packer-builds)

## PACKER TEMPLATE FILE

* PACKER FILE
  * [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-lxc-debian/template.pkr.hcl)
* HARDWARE
  * CPU: 2 Cores
  * RAM: 2GB
  * Disk Size: 30 GB
* USER SETUP
  * [user-setup-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/user-setup-jeff.sh)
* SECURITY (SSH KEYS)
  * [security-move-packer-github-temp-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/security-move-packer-github-temp-keys-to-jeff.sh)
    * Move
      [packer-github-temp](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-files/packer-github-temp)
      and
      [packer-github-temp.pub](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-files/packer-github-temp.pub)
      file to /home/jeff/.ssh
* PROVISIONING (SYSTEM LEVEL)
  * [provisioning-update-upgrade.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/provisioning-update-upgrade.sh)
    * option to turn off periodic updates and auto-upgrades
  * [provisioning-install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/provisioning-install-packages.sh)
    * htop, tmux, unzip, etc.
  * [provisioning-install-go-and-configure-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/provisioning-install-go-and-configure-for-root.sh)
* CONFIGURE (USER LEVEL)
  * [configure-move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/configure-move-welcome-file-to-jeff.sh)
    * Move
      [welcome.txt](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-files/welcome.txt)
      file to /home/jeff
  * [configure-bashrc-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/configure--bashrc-for-root.sh)
  * [configure-bashrc-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/configure-bashrc-for-jeff.sh)
  * [configure-git-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/configure-git-for-jeff.sh)
  * [configure-dircolors-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/configure-dircolors-for-jeff.sh)
    * Move
      [.dircolors](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-files/.dircolors)
      file to /home/jeff
  * [configure-prompt-for-jeff](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/configure-prompt-for-jeff.sh)
  * [configure-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/configure-go-for-jeff.sh)
  * [configure-pull-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/configure-pull-repos-for-jeff.sh)
* SERVICES
  * [services-install-hello-go.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/services-install-hello-go.sh)
    * Create executable /root/bin/hello-go from
      [hello-go-deploy-gce](https://github.com/JeffDeCola/hello-go-deploy-gce#hello-go-deploy-gce)
  * [services-enable-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/services-enable-at-boot.sh)
    * Move
      [hello-go.service](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-files//hello-go.service)
      to /lib/systemd/system/
* CLEANUP
  * [cleanup-packer-github-temp-keys.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/proxmox-images/jeffs-proxmox-image-lxc-debian/install-scripts/cleanup-packer-github-temp-keys.sh)
* APPS
  * go: 1.26.2
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
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/proxmox-images/jeffs-proxmox-image-lxc-debian/build-image.sh)
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

The image is located....
