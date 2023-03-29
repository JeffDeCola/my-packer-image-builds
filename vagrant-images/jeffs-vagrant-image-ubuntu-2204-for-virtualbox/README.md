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
* Size: 2GB
* Configure and provision
  * [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/install-scripts/update-upgrade-system.sh)
    Update & upgrade (option to turn off periodic updates and auto-upgrades)
  * [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/install-scripts/install-packages.sh)
     Install packages like htop, tmux, unzip, etc.
  * [add-user-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/install-scripts/add-user-jeff.sh)
    Add user jeff
  * [move-welcome-file.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/install-scripts/move-welcome-file.sh)
    Move welcome file.txt /home/vagrant
  * [move-vagrant-insecure-public-key.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/install-scripts/move-vagrant-insecure-public-key.sh)
    Move vagrant insecure public key to /vagrant/.ssh/authorized_keys
* Source Image: vagrant
  * **"generic/ubuntu2204"** for vagrant on linux or windows
* Custom Image: vagrant
  * ubuntu 22.04 for vagrant on linux or windows
* Contains:
  * Add user jeff

## BUILD IMAGE

Validate and build on virtualbox linux,

```bash
packer validate template.pkr.hcl
packer build -force template.pkr.hcl
```

Or use
[build-image.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/vagrant-images/jeffs-vagrant-image-ubuntu-2204-for-virtualbox/build-image.sh),

```bash
sh build-image.sh
```

## TEST IMAGE

We now have,

* The vagrant image (box) in `/box/jeffs-vagrant-image-ubuntu-2204-for-virtualbox.box`.
* The Vagrantfile in `/box/Vagrantfile`.

I suggest you update your Vagrantfile to add more resources,
but this is just a test.

First, add your vagrant image (box) to vagrant,

```bash
vagrant box add "jeffs-vagrant-image-ubuntu-2204-for-virtualbox"
vagrant box list
```

Now vagrant up your box (build and deploy),

```bash
cd box
vagrant up
```

If you update your Vagrantfile you can connect with ssh,

```bash
vagrant ssh jeffs-vagrant-image-ubuntu-2204-for-virtualbox
vagrant ssh-config
ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@{IP}
```

Login with,

```text
username: vagrant
password: vagrant
```
