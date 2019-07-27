#!/bin/bash
# my-packer-image-builds set-pipeline.sh

fly -t ci set-pipeline -p my-packer-image-builds -c pipeline.yml --load-vars-from ../../../.credentials.yml
