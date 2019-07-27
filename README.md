# my-packer-image-builds

[![Maintainability](https://api.codeclimate.com/v1/badges/23dab087af17b9177ed8/maintainability)](https://codeclimate.com/github/JeffDeCola/my-packer-image-builds/maintainability)
[![Issue Count](https://codeclimate.com/github/JeffDeCola/my-packer-image-builds/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/my-packer-image-builds/issues)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)

`my-packer-image-builds` _is a place for me to create images via packer._

There will be no explanation on how this is done, refer to my
[packer cheat sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/orchestration/builds-deployment-containers/packer-cheat-sheet).

[GitHub Webpage](https://jeffdecola.github.io/my-packer-image-builds/).

* [GCE]()
  * jeffs-gce-ubuntu-1804
* [VAGRANT]()
  * jeffs-ubuntu-1804-virtualbox-vm-box

## GOOGLE COMPUTE ENGINE (GCE)

My packer builds at Google Computer Engine.

### jeffs-gce-ubuntu-1804

Packer file [gce-packer-template.json](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/gce-packer-template.json).

Using gce resources for build,

* ubuntu-1604-xenial-v20190628
* us-west1-a
* n1-standard-1

Configure and provision,

* [update-upgrade-system.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/update-upgrade-system.sh)
  Update & upgrade, turn off periodic updates and auto-upgrades.
* [add-user-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/add-user-jeff.sh)
  Add user jeff.
* [move-welcome-file-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/move-welcome-file-to-jeff.sh)
  Test to add file to /home/jeff.
* [add-gce-universal-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/add-gce-universal-ssh-keys-to-jeff.sh)
  Add a universal key so VMs can ssh into each other.
* [add-github-ssh-keys-to-root-and-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/add-github-ssh-keys-to-root.sh)
  Add keys for github to root.
* [add-github-ssh-keys-to-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/add-github-ssh-keys-to-jeff.sh)
  Add keys for github to jeff.
* [install-packages.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/install-packages.sh)
  Install packages like htop, tmux, unzip, etc...
* [install-docker.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/install-docker.sh)
  Install docker.
* [install-go-and-config-for-root.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/install-go-and-config-for-root.sh)
  Install go and config for user root.
* [config-go-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/config-go-for-jeff.sh)
  Config go for user jeff.
* [pull-private-repos-for-jeff.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/install-scripts/pull-private-repos-for-jeff.sh)
  Pull my-global-repo-scripts-private.

To build use
[build.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/build-image.sh),

```bash
sh build.sh
```

To deploy use
[create-instance-template.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/build-image.sh)
and
[create-instance-group.sh](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/gce/jeffs-gce-ubuntu-1804/create-instance-group.sh).

Will use,

* f1-micro
* us-west1

```bash
sh create-instance-template.sh
sh create-instance-group.sh
```

``ssh into your machine,

```bash
ssh -i ~/.ssh/google_compute_engine jeff@IP
```

## VAGRANT

My packer builds for vagrant.

### jeffs-ubuntu-1804-virtualbox-vm-box

Configuration,

* Goal - Create a vagrant box of ubuntu 18.04
* Using
  `iso/ubuntu-18.04.2-server-amd64.iso`
  ubuntu 18.04 .iso file.
* [Packer template file](https://github.com/JeffDeCola/my-packer-image-builds/blob/master/jeffs-ubuntu-1804-virtualbox-vm-box/vagrant-packer-template.json)
  to manage/configure this development environment

This build is located in my repo
[my-vagrant-boxes](https://github.com/JeffDeCola/my-vagrant-boxes#jeffs-ubuntu-1804-virtualbox-vm-box).

## UPDATE GITHUB WEBPAGE USING CONCOURSE (OPTIONAL)

For fun, I use concourse to update
[my-packer-image-builds GitHub Webpage](https://jeffdecola.github.io/my-packer-image-builds/)
and alert me of the changes via repo status and slack.

A pipeline file [pipeline.yml](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/ci/pipeline.yml)
shows the entire ci flow. Visually, it looks like,

![IMAGE - my-packer-image-builds concourse ci pipeline - IMAGE](docs/pics/my-packer-image-builds-pipeline.jpg)

The `jobs` and `tasks` are,

* `job-readme-github-pages` runs task
  [readme-github-pages.sh](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/ci/scripts/readme-github-pages.sh).

The concourse `resources types` are,

* `my-packer-image-builds` uses a resource type
  [docker-image](https://hub.docker.com/r/concourse/git-resource/)
  to PULL a repo from github.
* `resource-slack-alert` uses a resource type
  [docker image](https://hub.docker.com/r/cfcommunity/slack-notification-resource)
  that will notify slack on your progress.
* `resource-repo-status` uses a resource type
  [docker image](https://hub.docker.com/r/dpb587/github-status-resource)
  that will update your git status for that particular commit.

For more information on using concourse for continuous integration,
refer to my cheat sheet on [concourse](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/continuous-integration-continuous-deployment/concourse-cheat-sheet).
