#!/bin/sh -e
# security-move-packer-github-temp-keys-to-jeff.sh

echo " "
echo "************************************************************************"
echo "************* security-move-packer-github-temp-keys-to-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Make /home/jeff/.ssh if it doesn't exist"
[ -d /home/jeff/.ssh ] || mkdir /home/jeff/.ssh
echo " "

echo "chmod 700 for .ssh directory"
chmod 700 /home/jeff/.ssh
echo " "

echo "chown owner to jeff:jeff for /home/jeff/.ssh"
chown jeff:jeff /home/jeff/.ssh
echo " "

echo "mv /tmp/packer_github_temp* /home/jeff/.ssh"
mv /tmp/packer_github_temp /home/jeff/.ssh/packer_github_temp
mv /tmp/packer_github_temp.pub /home/jeff/.ssh/packer_github_temp.pub
echo " "

echo "chmod 600 for both keys"
chmod 600 /home/jeff/.ssh/packer_github_temp*
echo " "

echo "chown owner to jeff:jeff for both keys"
chown jeff:jeff /home/jeff/.ssh/packer_github_temp
chown jeff:jeff /home/jeff/.ssh/packer_github_temp.pub
echo " "

echo "Put github.com fingerprint in known_hosts file"
runuser -l jeff -c 'ssh-keyscan github.com >> /home/jeff/.ssh/known_hosts'
echo " "

echo "chmod 600 for known_hosts file"
chmod 600 /home/jeff/.ssh/known_hosts
echo " "

echo "chown owner to jeff:jeff for known_hosts file"
chown jeff:jeff /home/jeff/.ssh/known_hosts
echo " "

echo "Start ssh agent for jeff and add key"
runuser -l jeff << 'EOF'
eval "$(ssh-agent -s)"
ssh-add /home/jeff/.ssh/packer_github_temp
EOF
echo " "

echo "Clean up ssh agent directory"
rm -rf /home/jeff/.ssh/agent
echo " "

echo "*************** security-move-packer-github-temp-keys-to-jeff.sh (END) *"
echo "************************************************************************"
echo " "
