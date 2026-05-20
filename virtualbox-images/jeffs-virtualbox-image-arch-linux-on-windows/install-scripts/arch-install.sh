#!/bin/bash
# arch-install.sh
#
# Runs inside the Arch Linux live ISO environment
# Does the full installation: partition, pacstrap, configure, GRUB, users

echo "************************************************************************"
echo "* arch-install.sh (START) **********************************************"
echo "************************************************************************"
echo " "

# ----------------------------------------
# STEP 1 — Partition disk
# /dev/sda is the VirtualBox disk

echo "Partitioning disk"
parted /dev/sda --script mklabel msdos
parted /dev/sda --script mkpart primary ext4 1MiB 100%
parted /dev/sda --script set 1 boot on
echo " "

# ----------------------------------------
# STEP 2 — Format partitions

echo "Formatting partitions"
mkfs.ext4 /dev/sda1
echo " "

# ----------------------------------------
# STEP 3 — Mount

echo "Mounting"
mount /dev/sda1 /mnt
echo " "

# ----------------------------------------
# STEP 4 — Update mirrors and install base system

echo "Installing base system via pacstrap"
pacman -Sy --noconfirm archlinux-keyring
pacstrap /mnt \
  base \
  base-devel \
  linux \
  linux-firmware \
  grub \
  networkmanager \
  openssh \
  sudo \
  vim \
  git \
  curl \
  wget \
  docker \
  nano \
  net-tools \
  tmux \
  htop \
  btop \
  unzip \
  bash-completion \
  rsync \
  go
echo " "

# ----------------------------------------
# STEP 5 — Generate fstab

echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab
echo " "

# ----------------------------------------
# STEP 6 — chroot and configure system

echo "Configuring system..."
arch-chroot /mnt /bin/bash <<'EOF'

  # Locale
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen
  echo "LANG=en_US.UTF-8" > /etc/locale.conf

  # Timezone
  ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
  hwclock --systohc

  # Hostname
  echo "arch-vb-template" > /etc/hostname
  cat <<HOSTS > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   arch-vb-template.localdomain arch-vb-template
HOSTS

  # Go environment for root
  echo "" >> /root/.bashrc
  echo "# Go environment" >> /root/.bashrc
  echo "export GOBIN=/root/go/bin" >> /root/.bashrc
  echo "export PATH=/usr/local/go/bin:\$PATH" >> /root/.bashrc
  echo "export PATH=\$GOBIN:\$PATH" >> /root/.bashrc

  # Pre-generate SSH host keys so sshd can start cleanly on first boot
  ssh-keygen -A

  # Enable services
  systemctl enable NetworkManager
  systemctl enable sshd
  systemctl enable docker

  # wheel group needs sudo access
  sed -i 's/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers

EOF

# ----------------------------------------
# STEP 7 — Install GRUB

echo "Installing GRUB"
arch-chroot /mnt /bin/bash <<'EOF'

  grub-install --target=i386-pc /dev/sda
  grub-mkconfig -o /boot/grub/grub.cfg

EOF

# ----------------------------------------
# STEP 8 — Create users

echo "Creating users"
arch-chroot /mnt /bin/bash <<'EOF'

  # packer user (key auth only — password disabled in sshd_config)
  useradd -m -s /bin/bash packer
  echo "packer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/packer
  chmod 440 /etc/sudoers.d/packer

  # jeff user
  useradd -m -s /bin/bash jeff
  usermod -aG wheel,docker,systemd-journal jeff
  passwd -l jeff

  # SSH key for packer user (virtualbox_universal — must match
  # the live-ISO bootstrap key so Packer can reconnect after reboot)
  mkdir -p /home/packer/.ssh
  chmod 700 /home/packer/.ssh
  echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDsF0+wNvw32mG8XGAldIMZUaMl1TzAw8w9BYLIbAoN3r/2E5jyw+UCXlxpfkMPwuP8wQJcuQOa18VXRe16SsWBLtwyERCgIcA9s5aFWquTA/jEHwaMc75ZDQlxBU4w0IB2jZdVYgi9Q1vRf+XWeS2/wnDsWFMD36pT0IPH2ecKmH2FLYX7LoOEUknGrSWKd2XHxNTsZXwdEjpOdd+r0HFnGXxYjPqOGwxDWvsVhf8YMAMQc7nI94Jr+T6h2pdAJkXNalC0RMO1wI0W7mgCID2Nie+FMnvtxamtv6S9y3D3qoDUQudBvywBo9upLdasHb1HADOVwFoVS+7vq1gp1+ZzNqBIqlcIA81BYcwsPblIDwmJIFbv09sxzcbbT3nL1l5j3s3WqZU36fYyU88Bvv3EM4FRUs2kUjGNqTejorAvA0wlkhf8AxDK7NkXNOymk0X62BlA5N82fC1UFs9xVaQRg1MVS5b9jsTZQXaXG+rUvN3ZKl3IOKVvQSMT57fxofVQUrQHO6jft/yZ99gh6pgKyE9PzGTJPi2bWovYbt8P/ogspHiakieyKZYaAZi5p+Z50vTsFJy6GQt2lnreUw1PeGNYBTe73STPru4FvdWyf6eSQpgI4GdCWKEwwpCxuVqNj3yOpkproDvj37u9NBl0YYzfxDKm1F7+GInv09XXvw== virtualbox universal keys" > /home/packer/.ssh/authorized_keys
  chmod 600 /home/packer/.ssh/authorized_keys
  chown -R packer:packer /home/packer/.ssh

EOF

# ----------------------------------------
# STEP 9 — Configure SSH

echo "Configuring SSH..."
arch-chroot /mnt /bin/bash <<'EOF'

  # Allow SSH key auth, disable root login
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
  sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

EOF

# ----------------------------------------
# STEP 10 — Unmount and reboot

echo "Unmounting and rebooting into installed system..."
umount -R /mnt

echo "************************************************************************"
echo "* arch-install.sh (END) ************************************************"
echo "************************************************************************"
echo " "

reboot
