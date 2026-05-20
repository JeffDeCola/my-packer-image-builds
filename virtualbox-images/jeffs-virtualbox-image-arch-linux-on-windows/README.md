# jeffs-virtualbox-image-arch-linux-on-windows

[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)
[![MIT License](https://img.shields.io/:license-mit-blue.svg)](https://jeffdecola.mit-license.org)

_Using packer to build a virtualbox image
from an Arch Linux iso
containing the Arch Linux rolling-release OS
for virtualbox on windows._

Table of Contents

* [OVERVIEW](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows#overview)
* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows#build-image)
* [USE IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows#use-image)
* [SOME OTHER CONFIGURATIONS TO DO](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows#some-other-configurations-to-do)
* [FIX SLOW SUDO](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows#fix-slow-sudo)

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
  * [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/template.pkr.hcl)
* BOOTSTRAP
  * [http/bootstrap.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/http/bootstrap.sh)
  * Served by Packer's HTTP server during live ISO boot to create the `packer`
    user with the universal SSH key
  * hostname: `arch-vb-template`
* HARDWARE
  * CPU: 4 Cores
  * MEMORY: 8GB
  * Disk Size: 40GB
* INSTALLER (RUNS IN LIVE ISO ENVIRONMENT)
  * [arch-install.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/arch-install.sh)
  * Partitions disk, runs `pacstrap` for base system + Go + Docker + dev tools,
    configures locale/timezone/hostname, installs GRUB, creates `packer` and `jeff`
    users, configures SSH, reboots into installed system
* SECURITY (SSH KEYS)
  * [security-prepend-virtualbox-universal-key-to-authorized-keys-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/security-prepend-virtualbox-universal-key-to-authorized-keys-jeff.sh)
  * [security-move-packer-github-temp-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/security-move-packer-github-temp-keys-to-jeff.sh)
* PROVISIONING (SYSTEM LEVEL)
  * [provisioning-update-upgrade.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/provisioning-update-upgrade.sh)
  * [provisioning-run-a-dockerhub-image-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/provisioning-run-a-dockerhub-image-at-boot.sh)
* CONFIGURE (USER LEVEL)
  * [configure-move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/configure-move-welcome-file-to-jeff.sh)
  * [configure-bashrc-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/configure-bashrc-for-root.sh)
  * [configure-bashrc-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/configure-bashrc-for-jeff.sh)
  * [configure-git-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/configure-git-for-jeff.sh)
  * [configure-dircolors-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/configure-dircolors-for-jeff.sh)
  * [configure-prompt-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/configure-prompt-for-jeff.sh)
  * [configure-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/configure-go-for-jeff.sh)
  * [configure-move-vscode-server-settings-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/configure-move-vscode-server-settings-file-to-jeff.sh)
  * [configure-pull-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/configure-pull-repos-for-jeff.sh)
* SERVICES
  * [services-install-hello-go.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/services-install-hello-go.sh)
  * [services-enable-at-boot.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/services-enable-at-boot.sh)
* CLEANUP
  * [cleanup-packer-github-temp-keys.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/install-scripts/cleanup-packer-github-temp-keys.sh)
* APPS
  * docker: 29.4.2
  * go: 1.26.2
* SERVICES
  * [hello-go-deploy-gce](https://hub.docker.com/r/jeffdecola/hello-go-deploy-gce)
    dockerhub image runs at boot
  * /home/jeff/hello-go binary runs at boot

## BUILD IMAGE

Build the OVF appliance with packer, then import it into VirtualBox.

* [build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/build-image.sh)
  runs packer and produces an OVF in `D:/virtualbox/<vm-name>/`
* [convert-ovf-to-vbox.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/convert-ovf-to-vbox.sh)
  imports the most recent OVF into VirtualBox so it appears in the Manager UI

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
    -var "image_name=virtualbox-image-arch-linux" \
    template.pkr.hcl
```

To build the image using
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/virtualbox-images/jeffs-virtualbox-image-arch-linux-on-windows/build-image.sh),

```bash
./build-image.sh
```

Which runs,

```bash
packer build -force \
    -var "image_name=virtualbox-image-arch-linux" \
    template.pkr.hcl
```

The build produces an OVF file.

```bash
./convert-ovf-to-vbox.sh
```

You should see your VM named `jeffs-virtualbox-image-arch-linux-YYYYMMDD`
(date in UTC). You can also open the VirtualBox Manager UI to see it in
the list.

## USE IMAGE

Convert to vbox.

```bash
./convert-ovf-to-vbox.sh
```

Start the VM from the VirtualBox Manager UI, or from git bash,

```bash
"/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" startvm \
    "jeffs-virtualbox-image-arch-linux-20260506"
```

### Networking

VirtualBox Manager UI → Settings → Network → Adapter 1 →
Attached to: Bridged Adapter

Then check your router's DHCP client list to find the VM's IP.

### SSH in

SSH in as the `packer` user (the universal key was installed during
the build),

```bash
ssh -i ~/.ssh/virtualbox_universal packer@<IP_ADDRESS>
```

Add password for jeff,

```bash
sudo passwd jeff
```

Then log out and SSH in as jeff (the universal key was also added to
jeff's authorized_keys),

```bash
ssh -i ~/.ssh/virtualbox_universal jeff@<IP_ADDRESS>
```

### Services

Two `hello-go` services are configured to run at boot:

* `hello-go.service` — runs the locally-built `/home/jeff/hello-go` binary
* `hello-go-deploy-gce` — runs the dockerhub image as a docker container

View service output,

```bash
journalctl -u hello-go.service -f
docker logs hello-go-deploy-gce -f
```

Stop services (this run only),

```bash
sudo systemctl stop hello-go.service
sudo docker stop hello-go-deploy-gce
```

Permanently disable services so they don't come back at boot,

```bash
sudo systemctl disable hello-go.service
sudo docker stop hello-go-deploy-gce && sudo docker rm hello-go-deploy-gce
```

## SOME OTHER CONFIGURATIONS TO DO

The hostname baked into the image is `arch-vb-template`. Change it to
something specific to this VM,

```bash
sudo hostnamectl set-hostname <NEW_HOSTNAME>
```

Also update `/etc/hosts` so the new hostname resolves locally,

```bash
sudo sed -i "s/arch-vb-template/<NEW_HOSTNAME>/g" /etc/hosts
```

Generate fresh SSH keys for jeff (the build doesn't create personal
keypairs, only installs the universal key for remote access),

```bash
/home/jeff/development/my-linux-shell-scripts/linux/generate-ssh-keys/generate-ssh-keys.sh
```

Add the new public key to `~/.ssh/authorized_keys` on whatever remote
hosts you want to SSH to from this VM, and to your GitHub account if
you'll be pushing from here.

## FIX SLOW SUDO

* Symptom: `sudo true` takes ~25s,
  `ssh <host> true` takes ~50s,
  scp crawls at ~190 kB/s.
Cause: `pam_systemd_home.so` in `/etc/pam.d/system-auth`
  waits on `systemd-homed.service`
  which ships disabled by default. Every PAM auth pays the dbus timeout.

Fix (pick one):

```bash
sudo systemctl enable --now systemd-homed.service
```

Or, if not using systemd-homed, remove the four
`pam_systemd_home.so` lines from `/etc/pam.d/system-auth`.

Bake into Packer provisioner for new Arch VMs.
