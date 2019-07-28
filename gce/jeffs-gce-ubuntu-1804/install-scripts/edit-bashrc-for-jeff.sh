#!/bin/bash -e
# my-packer-image-builds edit-bashrc-for-jeff.sh

echo " " 
echo "************************************************************************"
echo "************************************** edit-bashrc-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

runuser -l jeff -c 'mkdir /home/jeff/.bash'
cd /home/jeff/.bash
runuser -l jeff -c 'git clone git://github.com/jimeh/git-aware-prompt.git'

echo "Add to .bashrc"
echo ' 
# Added by Jeff
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
 ' >> /home/jeff/.bashrc
echo " "

echo "**************************************** edit-bashrc-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "