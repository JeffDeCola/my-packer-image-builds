#!/bin/bash
# my-packer-image-builds destroy-pipeline.sh

fly -t ci destroy-pipeline --pipeline my-packer-image-builds
