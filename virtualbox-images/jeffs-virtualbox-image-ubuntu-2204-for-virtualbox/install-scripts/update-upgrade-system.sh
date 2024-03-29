#!/bin/sh
# my-packer-image-builds jeffs-virtualbox-image-ubuntu-2204-for-virtualbox update-upgrade-system.sh

echo " "
echo "********************************************************************"
echo "********************************* update-upgrade-system.sh (START) *" 
echo "You are root in /home/packer"
echo " "

echo "update & upgrade system (quiet mode)"
while true; do
  sudo apt-get -qq -y update
  sudo apt-get -qq -y upgrade

  if [ $? -eq 0 ]; then
    break
  fi
done
echo " "

echo "Add vagrant user to sudoers"
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
echo " "

#echo "Turn off periodic updates"
#echo "Open the file /etc/apt/apt.conf.d/10periodic and change:"
#echo '   - FROM - APT::Periodic::Update-Package-Lists "1";'
#echo '   - TO   - APT::Periodic::Update-Package-Lists "0";'
#echo 'APT::Periodic::Unattended-Upgrade "0";' >> /etc/apt/apt.conf.d/10periodic
#echo " "

#echo "Turn off auto-upgrades"
#echo "Open the file /etc/apt/apt.conf.d/20auto-upgrades and add:"
#echo '   - APT::Periodic::Update-Package-Lists "1";'
#echo '   - APT::Periodic::Unattended-Upgrade "0";'
#echo -e 'APT::Periodic::Update-Package-Lists "1";\nAPT::Periodic::Unattended-Upgrade "0";' >> /etc/apt/apt.conf.d/20auto-upgrades
#echo " "

#echo "Increase file limits"
#echo -e "*       soft    nofile  100000\n*       hard    nofile  100000\nroot    soft    nofile  100000\nroot    hard    nofile  100000" >> /etc/security/limits.conf
#echo "fs.inotify.max_user_watches=100000" >> /etc/sysctl.conf
#echo " "

echo "*************************************** update-upgrade-system.sh (END) *"
echo "************************************************************************"
echo " "
