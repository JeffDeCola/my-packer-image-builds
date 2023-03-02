#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 clone-git-aware-prompt-for-jeff.sh

echo " " 
echo "************************************************************************"
echo "*************************** clone-git-aware-prompt-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Make /home/jeff/.bash"
runuser -l jeff -c 'mkdir /home/jeff/.bash'
echo " "

echo "Git clone git-aware-prompt"
echo "You must cd into the directory in same command"
runuser -l jeff -c 'cd /home/jeff/.bash; git clone git@github.com:jimeh/git-aware-prompt.git'
echo " "

echo "Add git-aware-prompt to /home/jeff/.bashrc"
# Must escape $ with \$
cat >> /home/jeff/.bashrc <<CONF

# JEFF ADDED - GIT PROMPT
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "\${GITAWAREPROMPT}/main.sh"
PS1="\\\${debian_chroot:+(\\\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\$txtcyn\]\\\$git_branch\[\$txtred\]\\\$git_dirty\[\$txtrst\]\\\$ "
CONF
echo " "

echo "***************************** clone-git-aware-prompt-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "