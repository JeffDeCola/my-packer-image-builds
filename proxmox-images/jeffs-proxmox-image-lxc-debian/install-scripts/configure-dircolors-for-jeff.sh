#!/bin/sh -e
# configure-dircolors-for-jeff.sh

echo " "
echo "************************************************************************"
echo "****************************** configure-dircolors-for-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "cd /home/jeff"
cd /home/jeff
echo " "

echo "mv /tmp/.dircolors /home/jeff/"
mv /tmp/.dircolors /home/jeff
echo " "

echo "chown owner to jeff"
chown jeff:jeff /home/jeff/.dircolors
echo " "

echo "Add colors to /home/jeff/.bashrc"
# Must escape $ with \$
cat >> /home/jeff/.bashrc <<CONF

# COLORS - FILE TYPES AND DIRECTORIES using .dircolors -------------------------

# JEFF ADDED - .dircolors file
# Use the .dircolors file for directories and file extensions
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# COLORS - SHELL COMMANDS  ----------------------------------------------------

# JEFF ADDED - GREP_COLORS
export GREP_COLORS='ms=01;33'   # BOLD YELLOW
alias grep='grep --color=auto -i'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# gcc colors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# ls colors
alias ls='ls --color=auto'
CONF
echo " "

echo "******************************** configure-dircolors-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
