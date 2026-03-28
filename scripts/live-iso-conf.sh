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

# Setting the timezone
arch-chroot /mnt ln -sf "/usr/share/zoneinfo/${AREA}/${LOCATION}" /etc/localtime
arch-chroot hwclock --systohc
# TODO: Configure time synchronization

# Locales
for LOC in "${LOCALES[@]}"; do
	arch-chroot /mnt sed -i "s/^#${LOC}/${LOC}/" /etc/locale.gen
done
arch-chroot /mnt locale-gen
echo "LANG=${LOCALE_LANG}" > /mnt/etc/locale.conf
echo "LC_MESSAGES=${LOCALE_MSG}" >> /mnt/etc/locale.conf
echo "KEYMAP=${TTY_KEYMAP}" > /mnt/etc/vconsole.conf
echo "FONT=${TTY_FONT}" >> /mnt/etc/vconsole.conf
echo "$HOSTNAME" > /mnt/etc/hostname

arch-chroot /mnt useradd -m -G wheel -s /bin/zsh "$USERNAME"
echo "${USERNAME}:${PASSWORD}" | arch-chroot /mnt chpasswd
echo "root:${ROOT_PASSWD}" | arch-chroot /mnt chpasswd
arch-chroot /mnt sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Regenerating initramfs
arch-chroot /mnt mkinitcpio -P

# Installing boot manager - GRUB
arch-chroot /mnt pacman -Sy grub efibootmgr
arch-chroot /mnt grub-install --target=i386-pc "$DISK_DEV"
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
