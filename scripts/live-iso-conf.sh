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
	exit 1
fi

# Synchronize the system clock
timedatectl

# WARNING: wiping the hard drive
wipefs -a "$DISK_DEV"

BOOTMODE=""
if [ -d /sys/firmware/efi ]; then
	BOOTMODE="UEFI"
else
	BOOTMODE="BIOS"
fi

parted -s "$DISK_DEV" mklabel gpt

if [[ "$BOOTMODE" == "BIOS" ]]; then
	parted -s "$DISK_DEV" mkpart primary 1MiB 3MiB
	parted -s "$DISK_DEV" set 1 bios_grub on
	parted -s "$DISK_DEV" mkpart primary 3MiB "$SWAP_END"
else
	parted -s "$DISK_DEV" mkpart ESP fat32 1MiB 513MiB
	parted -s "$DISK_DEV" set 1 esp on
	parted -s "$DISK_DEV" mkpart primary 513MiB "$SWAP_END"
fi

parted -s "$DISK_DEV" mkpart primary "$SWAP_END" "$SYSPART_END"
parted -s "$DISK_DEV" mkpart primary "$SYSPART_END" 100%

BOOTPART="${PART_PREF}1"
SWAP="${PART_PREF}2"
SYSPART="${PART_PREF}3"
USERPART="${PART_PREF}4"

if [[ "$BOOTMODE" == "UEFI" ]]; then
	mkfs.fat -F32 "$BOOTPART"
fi

mkfs.ext4 "$SYSPART"
mkfs.ext4 "$USERPART"
mkswap "$SWAP"
swapon "$SWAP"

mount "$SYSPART" /mnt
mkdir -p /mnt/home
mount "$USERPART" /mnt/home

if [[ "$BOOTMODE" == "UEFI" ]]; then
	mkdir -p /mnt/boot
	mount "$BOOTPART" /mnt/boot
fi

reflector --latest 20 --sort rate --age 12 \
	--protocol https --save /etc/pacman.d/mirrorlist

pacstrap -K /mnt "${BASE[@]}"

# Generate the file system table
genfstab -U /mnt >> /mnt/etc/fstab

# Setting the timezone
arch-chroot /mnt ln -sf "/usr/share/zoneinfo/${AREA}/${LOCATION}" /etc/localtime
arch-chroot /mnt hwclock --systohc
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

#temporarily disable password prompts
arch-chroot /mnt sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers

# Regenerating initramfs
arch-chroot /mnt mkinitcpio -P || true

# Installing boot manager - GRUB
GRUB_PCKGS=(grub)

if [[ "$BOOTMODE" == "UEFI" ]]; then
	GRUB_PCKGS+=(efibootmgr)
fi

arch-chroot /mnt pacman -Sy --noconfirm "${GRUB_PCKGS[@]}"

if [[ "$BOOTMODE" == "BIOS" ]]; then
	arch-chroot /mnt grub-install --target=i386-pc "$DISK_DEV"
else
	arch-chroot /mnt grub-install --target=x86_64-efi \
		--efi-directory=esp --bootloader-id=GRUB
fi

arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

REPO_PATH="$(cd "${SOURCE_DIR}/../" && pwd)"

cp -r "$REPO_PATH" "/mnt/home/${USERNAME}/"
arch-chroot /mnt chown -R "${USERNAME}:${USERNAME}" "/home/${USERNAME}/dotfiles"
