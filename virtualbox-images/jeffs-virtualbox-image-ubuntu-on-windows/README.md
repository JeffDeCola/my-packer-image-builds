# jeffs-virtualbox-image-ubuntu-on-windows

[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)
[![MIT License](https://img.shields.io/:license-mit-blue.svg)](https://jeffdecola.mit-license.org)

_Using packer to build a virtualbox image
from an ubuntu iso
containing the ubuntu 26.04 OS
for virtualbox on windows._

Table of Contents

* [OVERVIEW](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows#overview)
* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows#build-image)
* [USE IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows#use-image)
* [SOME OTHER CONFIGURATIONS TO DO](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows#some-other-configurations-to-do)
* [INSTALL GNOME DESKTOP (OPTIONAL)](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows#install-gnome-desktop-optional)

Documentation and Reference

* [packer](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* [virtualbox](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/development/development-environments/virtualbox-cheat-sheet#virtualbox-cheat-sheet)

## OVERVIEW

We will run packer on a windows machine using git bash.

```text
Git Bash (Windows) → Packer (Windows) → VirtualBox (Windows)
```

Prerequisites on windows machine

* [git bash](https://git-scm.com/downloads/win)
* [packer](https://developer.hashicorp.com/packer/install)
* [virtualbox](https://www.virtualbox.org/wiki/Downloads)
* SSH keypair `~/.ssh/virtualbox_universal` and `~/.ssh/virtualbox_universal.pub`

## PACKER TEMPLATE FILE

* PACKER FILE
  * [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/template.pkr.hcl)
* AUTOINSTALL
  * [http/user-data](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/http/user-data)
  * hostname: `ubuntu-vb-template`
* HARDWARE
  * CPU: 4 Cores
  * MEMORY: 8GB
  * Disk Size: 40GB
* USER SETUP
  * [user-setup-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/user-setup-jeff.sh)
* SECURITY (SSH KEYS)
  * [security-prepend-virtualbox-universal-key-to-authorized-keys-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/security-prepend-virtualbox-universal-key-to-authorized-keys-jeff.sh)
  * [security-move-packer-github-temp-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/security-move-packer-github-temp-keys-to-jeff.sh)
* PROVISIONING (SYSTEM LEVEL)
  * [provisioning-update-upgrade.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/provisioning-update-upgrade.sh)
  * [provisioning-install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/provisioning-install-packages.sh)
  * [provisioning-install-docker.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/provisioning-install-docker.sh)
  * [provisioning-run-a-dockerhub-image-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/provisioning-run-a-dockerhub-image-at-boot.sh)
  * [provisioning-install-go-and-configure-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/provisioning-install-go-and-configure-for-root.sh)
* CONFIGURE (USER LEVEL)
  * [configure-move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/configure-move-welcome-file-to-jeff.sh)
  * [configure-bashrc-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/configure-bashrc-for-root.sh)
  * [configure-bashrc-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/configure-bashrc-for-jeff.sh)
  * [configure-git-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/configure-git-for-jeff.sh)
  * [configure-dircolors-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/configure-dircolors-for-jeff.sh)
  * [configure-prompt-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/configure-prompt-for-jeff.sh)
  * [configure-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/configure-go-for-jeff.sh)
  * [configure-move-vscode-server-settings-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/configure-move-vscode-server-settings-file-to-jeff.sh)
  * [configure-pull-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/configure-pull-repos-for-jeff.sh)
* SERVICES
  * [services-install-hello-go.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/services-install-hello-go.sh)
  * [services-enable-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/services-enable-at-boot.sh)
* CLEANUP
  * [cleanup-packer-github-temp-keys.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/install-scripts/cleanup-packer-github-temp-keys.sh)
* APPS
  * docker: 29.4.2
  * go: 1.26.2
* SERVICES
  * [hello-go-deploy-gce](https://hub.docker.com/r/jeffdecola/hello-go-deploy-gce)
    dockerhub image runs at boot
  * /home/jeff/hello-go binary runs at boot

## BUILD IMAGE

No environment variables or tokens are needed for the VirtualBox build —
unlike the Proxmox build, there is no API to authenticate against. Packer
talks to VirtualBox locally via `VBoxManage.exe`.

Make sure `VBoxManage.exe` is on your PATH, or that VirtualBox is
installed at `C:\Program Files\Oracle\VirtualBox\` (the default location
that Packer will find on its own).

To validate your packer template file,

```bash
./build-image.sh -v
```

Which runs,

```bash
packer validate \
    -var "image_name=virtualbox-image-ubuntu" \
    template.pkr.hcl
```

To build the image using
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/build-image.sh),

```bash
./build-image.sh
```

Which runs,

```bash
packer build -force \
    -var "image_name=virtualbox-image-ubuntu" \
    template.pkr.hcl
```

The build takes ~15-20 minutes total — about 10 minutes for the Ubuntu
autoinstall and reboot, then a few more minutes for the provisioning
scripts to run inside the VM.

Check that the VM was created in VirtualBox,

```bash
"/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" list vms
```

You should see your new VM named `jeffs-virtualbox-image-ubuntu-YYYYMMDD`.
You can also open the VirtualBox Manager UI to see it in the list.

## USE IMAGE

After `./build-image.sh` completes, the VM exists as an .ovf file on
disk but isn't yet registered in VirtualBox. Convert it,

```bash
./convert-ovf-to-vbox.sh
```

This imports the OVF into VirtualBox so the VM appears in the Manager
UI sidebar and is ready to run. See
[convert-ovf-to-vbox.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/convert-ovf-to-vbox.sh)
for details.

Start the VM from the VirtualBox Manager UI, or from git bash,

```bash
"/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" startvm \
    "jeffs-virtualbox-image-ubuntu-20260506"
```

The VM uses NAT networking by default, so it gets a private IP
(typically `10.0.2.15`) reachable only from the host via port forwarding.
Add an SSH port forward to reach it,

Change networking to bridged in the VirtualBox UI
(Settings → Network → Adapter 1 → Attached to: Bridged Adapter)
to put the VM on your LAN with its own IP.

Goto router and get tht IP. I was having trouble login into packer.

```bash

SSH in as packer,

```bash
ssh -i ~/.ssh/virtualbox_universal packer@<IP_ADDRESS>
```

Set a password for jeff,

```bash
sudo passwd jeff
```

Exit and login to jeff,

```bash
ssh -i ~/.ssh/virtualbox_universal jeff@<IP_ADDRESS>
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

## SOME OTHER CONFIGURATIONS TO DO

Probably also want to change the hostname from `ubuntu-vb-template`,

```bash
sudo hostnamectl set-hostname <NEW_HOSTNAME>
```

Also want to create some id_rsa keys,

```bash
/home/jeff/development/my-linux-shell-scripts/linux/generate-ssh-keys/generate-ssh-keys.sh
```

Update the `~/.ssh/authorized_keys` file with the new public keys.

## INSTALL DESKTOP (OPTIONAL)

The image is a server build (no GUI). To add the GNOME desktop
environment to the VM,

```bash
sudo apt update
sudo apt install -y ubuntu-desktop-minimal
sudo systemctl set-default graphical.target
sudo reboot
```

After reboot, the VirtualBox window will show a graphical login. Use
the `jeff` user (set a password first if you haven't — see CLONE IMAGE).

For a lighter alternative, swap `ubuntu-desktop-minimal` for `xubuntu-core`
(XFCE, ~500MB instead of ~2GB) or `lubuntu-core` (LXQt, even lighter).
