# jeffs-vagrant-image-ubuntu-2204-for-virtualbox

[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

_Using packer to build a vagrant image (box)
containing the ubuntu 22.04 OS
for virtualbox on linux or windows._

Table on Contents

* [PACKER TEMPLATE FILE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox#packer-template-file)
* [BUILD IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox#build-image)
* [TEST IMAGE](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox#test-image)

Documentation and Reference

* My
  [packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/packer-cheat-sheet)
* My
  [vagrant cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/development/development-environments/vagrant-cheat-sheet)
* Online [vagrant box search](https://app.vagrantup.com/boxes/search)

## PACKER TEMPLATE FILE

* Packer file:
  [template.pkr.hcl](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/template.pkr.hcl)
* Size: ?????
* Configure and provision
  * [init.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/install-scripts/init.sh)
    Initial setup
  * [move-welcome-file.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/install-scripts/move-welcome-file.sh)
    Move welcome file /home/vagrant
  * [move-vagrant-insecure-public-key.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/install-scripts/move-vagrant-insecure-public-key.sh)
    Move vagrant insecure public key to authorized_keys
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/install-scripts/install-packages.sh)
    Install packages
  * [cleanup.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/install-scripts/cleanup.sh)
    Cleanup
* Source Image: vagrant
  * **"ubuntu/jammy64"** for vagrant on linux or windows
* Custom Image: vagrant
  * ubuntu 22.04 for vagrant on linux or windows
* Contains:
  * ??? golang 1.20.1 ????

## BUILD IMAGE

Validate and build on virtualbox linux,

```bash
packer validate template.pkr.hcl
packer build template.pkr.hcl
```

Or use
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/build-image.sh),

```bash
sh build-image.sh
```

## TEST IMAGE

Now we have the box in `/box/jeffs-vagrant-image-ubuntu-2204-for-virtualbox.box`.

Add/list/remove box to/from vagrant,

```bash
vagrant box add --name "ubuntu/jeffs-vagrant-image-ubuntu-2204-for-virtualbox" \
  --force jeffs-vagrant-image-ubuntu-2204-for-virtualbox.box
vagrant box list
vagrant box remove ubuntu/jeffs-vagrant-image-ubuntu-2204-for-virtualbox
```

Use as normal,

```bash
vagrant up
```

Connect,

```bash
vagrant ssh jeffs-vagrant-image-ubuntu-2204-for-virtualbox
ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@127.0.0.1
```
