# my-packer-image-builds

[![Maintainability](https://api.codeclimate.com/v1/badges/23dab087af17b9177ed8/maintainability)](https://codeclimate.com/github/JeffDeCola/my-packer-image-builds/maintainability)
[![Issue Count](https://codeclimate.com/github/JeffDeCola/my-packer-image-builds/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/my-packer-image-builds/issues)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)

_A place for me to create images via packer._

Table of Contents,

* [GOOGLE COMPUTE ENGINE (GCE)](https://github.com/JeffDeCola/my-packer-image-builds#google-compute-engine-gce)
* [VAGRANT](https://github.com/JeffDeCola/my-packer-image-builds#vagrant)

Documentation and reference,

* [packer-cheat-sheet](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/orchestration/builds-deployment-containers/packer-cheat-sheet)

[GitHub Webpage](https://jeffdecola.github.io/my-packer-image-builds/)

## MY PACKER IMAGES

_All sections in alphabetical order._

### GOOGLE COMPUTE ENGINE (GCE)

* [jeffs-gce-ubuntu-1904-xxxx](https://github.com/JeffDeCola/my-packer-image-builds/tree/master/google-compute-engine/jeffs-gce-ubuntu-1904)

  _My packer builds at Google Computer Engine._

### VAGRANT

* [jeffs-ubuntu-1804-virtualbox-vm-box](https://github.com/JeffDeCola/my-vagrant-boxes#jeffs-ubuntu-1804-virtualbox-vm-box)

  _My packer builds for vagrant to create a vagrant box of ubuntu 18.04.
  This build is located in my repo
  [my-vagrant-boxes](https://github.com/JeffDeCola/my-vagrant-boxes)._

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
