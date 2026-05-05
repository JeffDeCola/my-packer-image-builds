#!/bin/sh -e
# configure-pull-repos-for-jeff.sh

echo " "
echo "************************************************************************"
echo "***************************** configure-pull-repos-for-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "mkdir /home/jeff/development"
[ -d /home/jeff/development ] || runuser -l jeff -c 'mkdir /home/jeff/development'
echo " "

echo "Connect to github.com..."
runuser -l jeff -c 'ssh -i ~/.ssh/packer_github_temp -o IdentitiesOnly=yes -T git@github.com || :'
echo " "

# -----------------------------------------------
# GET my-linux-shell-scripts-private using ~/.ssh/packer_github_temp key

# runuser - run command as another user
#   -l jeff                    - login as jeff (load jeff's environment)
#   -c '...'                   - command to run
#       GIT_SSH_COMMAND=       - override SSH command used by git
#           ssh                - use ssh
#           -i ~/.ssh/...      - identity file (private key) to use
#           -o IdentitiesOnly  - only use the specified key, ignore others

echo "git clone my-linux-shell-scripts-private..."
runuser -l jeff -c 'GIT_SSH_COMMAND="ssh -i ~/.ssh/packer_github_temp -o IdentitiesOnly=yes" \
    git clone git@github.com:JeffDeCola/my-linux-shell-scripts-private.git \
    /home/jeff/development/my-linux-shell-scripts-private'
echo " "

echo "******************************* configure-pull-repos-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
