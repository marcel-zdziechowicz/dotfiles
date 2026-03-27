#!/bin/bash
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SOURCE_DIR}/../variables.sh"

# Following the ArchWiki Installation guide
loadkeys "$TTY_KEYMAP"
setfont  "$TTY_FONT"

# Check for internet connection
if ! ping -c 1 ping.archlinux.org >/dev/null; then
	echo "No Internet connection."
	# TODO: Try connecting with WiFi
fi

# Synchronize the system clock
timedatectl

# WARNING: wiping the hard drive
wipefs -a "$DISK_DEV"

# TODO: Configurable partitioning
parted -s "$DISK_DEV" mklabel gpt
parted -s "$DISK_DEV" mkpart primary 1MiB 3MiB
parted -s "$DISK_DEV" set 1 bios_grub on
parted -s "$DISK_DEV" mkpart primary 3MiB "$SWAP_END"
parted -s "$DISK_DEV" mkpart primary "$SWAP_END" 100%

SWAP="${PART_PREF}2"
SYSPART="${PART_PREF}3"

mkfs.btrfs "$SYSPART"
mkswap "$SWAP"
swapon "$SWAP"

mount "$SYSPART" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
umount /mnt

mount -o subvol=@ "$SYSPART" /mnt
mkdir -p /mnt/home
mount -o subvol=@home "$SYSPART" /mnt/home

reflector --latest 20 --sort rate --age 12 \
	--protocol https --save /etc/pacman.d/mirrorlist

pacstrap -K /mnt base linux linux-firmware sudo zsh

# Generate the file system table
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt useradd -m -G wheel -s /bin/zsh "$USERNAME"
echo "${USERNAME}:${PASSWORD}" | arch-chroot /mnt chpasswd
arch-chroot /mnt sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
