# jeffs-virtualbox-image-ubuntu-2204-for-virtualbox

[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

_Using packer to build a virtualbox image
from an ubuntu 20.04 iso
containing the ubuntu 22.04 OS
for virtualbox on linux or windows._

Table of Contents

* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox#build-image)
* [TEST IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox#test-image)

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)

## PACKER TEMPLATE FILE

* Packer file:
  [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox/template.pkr.hcl)
* CloudInit file
  [user-data](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox/http/user-data)
  used to answer questions during setup (preseed is dead)
* Size: ??????
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox/install-scripts/update-upgrade-system.sh)
    Update & upgrade (option to turn off periodic updates and auto-upgrades)
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox/install-scripts/install-packages.sh)
     Install packages like htop, tmux, unzip, etc.  
  * [add-user-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox/install-scripts/add-user-jeff.sh)
    Add user jeff
  * [move-welcome-file-to-packer.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox/install-scripts/move-welcome-file-to-packer.sh)
    Move welcome file.txt /home/packer
* Source Image: iso
  * **"ubuntu-22.04.2-live-server-amd64.iso"** for linux
* Custom Image: virtualbox
  * ubuntu 22.04 for virtualbox on linux or windows
* Contains:
  * Add user jeff

## BUILD IMAGE

Get the iso ubuntu 22.04 for virtualbox on linux or windows.

```bash
cd iso
wget "https://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso"
```

Note, the preseed file is dead, we are using Cloudinit to answer the questions
during setup.

Validate and build on virtualbox linux or windows,

```bash
packer validate template.pkr.hcl
packer build template.pkr.hcl
```

Or use
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/virtualbox-images/jeffs-virtualbox-image-ubuntu-2204-for-virtualbox/build-image.sh),

```bash
sh build-image.sh
```

## TEST IMAGE

See if it boots up with virtualbox.

Login with,

```text
username: vagrant
password: vagrant
```
