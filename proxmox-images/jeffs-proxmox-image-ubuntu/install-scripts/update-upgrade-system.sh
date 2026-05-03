#!/bin/sh
# update-upgrade-system.sh

echo " "
echo "************************************************************************"
echo "********************************************* add-user-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "update & upgrade system (quiet mode)"
while true; do
  apt-get -qq -y update
  # This will suppress any prompts about configuration file changes
  # and keep the existing ones
  DEBIAN_FRONTEND=noninteractive \
  apt-get -qq -y \
    -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" \
    upgrade && break
done

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
