#!/bin/sh -e
# my-packer-image-builds add-colors-for-jeff.sh

echo " " 
echo "************************************************************************"
echo "*************************************** add-colors-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "cd /home/jeff"
cd /home/jeff
echo " "

echo "mv /tmp/.dircolors /home/jeff/"
mv /tmp/.dircolors /home/jeff
echo " "

echo "chown owner to jeff"
chown jeff /home/jeff/.dircolors
echo " "

echo "Add colors to /home/jeff/.bashrc"
# Must escape $ with \$
cat >> /home/jeff/.bashrc <<CONF

# JEFF ADDED - GCC COLORS (VARIOUS)
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# JEFF ADDED - GREP_COLORS (BOLD YELLOW)
export GREP_COLORS='ms=01;33'

# JEFF ADDED - LS_COLORS using ~/.dircolors)
test -r ~/.dircolors && eval "\$(dircolors ~/.dircolors)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
CONF
echo " "

echo "***************************************** add-colors-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "