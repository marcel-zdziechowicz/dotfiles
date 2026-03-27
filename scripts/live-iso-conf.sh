#!/bin/bash
set -euo pipefail
source ../variables.sh

# Following the ArchWiki Installation guide
loadkeys "$TTY_KEYMAP"
setfont  "$TTY_FONT"

# Check for internet connection
if ! ping -c 1 >/dev/null; then
	echo "No Internet connection."
	# TODO: Try connecting with WiFi
fi

# Synchronize the system clock
timedatectl

# Downloading the dotfiles
git clone https://github.com/marcel-zdziechowicz/dotfiles.git

# WARNING: wiping the hard drive
wipefs -a "$DISK_DEV"

# TODO: Configurable partitioning
parted -s "$DISK_DEV" mklabel gpt
parted -s "$DISK_DEV" mkpart primary 1MiB 3MiB
parted -s "$DISK_DEV" set 1 bios_grub on
parted -s "$DISK_DEV" mkpart primary 3MiB 16387MiB
parted -s "$DISK_DEV" mkpart primary 16387MiB 100%

SWAP = "${PART_PREF}2"
SYSPART = "${PART_PREF}3"

mkfs.btrfs -f -O compress=zstd "$SYSPART"
mkswap "$SWAP"
swapon "$SWAP"

mount "$SYSPART" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
umount /mnt

mount -o subvol=@,compress=zstd "$SYSPART" /mnt
mkdir -p /mnt/home
mount -o subvol=@home,compress=zstd "$SYSPART" /mnt/home

reflector --latest 20 --sort rate --age 12 \
	--protocol https --save /etc/pacman.d/mirrorlist

pacstrap -K /mnt base linux linux-firmware zsh

# Generate the file system table
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt useradd -m -G wheel /bin/zsh "$USERNAME"
echo "${USERNAME}:${PASSWORD}" | arch-chroot /mnt chpasswd
arch-chroot /mnt sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers


