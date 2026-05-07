#!/bin/bash
# Runs in the Arch live ISO during boot.
# Creates the packer user with the virtualbox_universal key
# so Packer can SSH in to run arch-install.sh.
#
# Usage: bootstrap.sh <pubkey-url>

set -e

PUBKEY_URL="$1"

# Create packer user
useradd -m -s /bin/bash packer

# Install authorized_keys
mkdir -p /home/packer/.ssh
chmod 700 /home/packer/.ssh
curl -fsSL "$PUBKEY_URL" -o /home/packer/.ssh/authorized_keys
chmod 600 /home/packer/.ssh/authorized_keys
chown -R packer:packer /home/packer/.ssh

# NOPASSWD sudo
echo 'packer ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/packer
chmod 440 /etc/sudoers.d/packer

# Start sshd so Packer can connect
systemctl start sshd
