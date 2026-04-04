TTY_KEYMAP="pl2"
TTY_FONT="Lat2-Terminus16"

# Array of locales to set in 
# you fresh Arch installation
# these work for me. You can
# find them in /etc/locale.gen
LOCALES=("en_US.UTF-8 UTF-8" "pl_PL.UTF-8 UTF-8")

# This will be used as the value
# for LANG in /etc/locale.conf
LOCALE_LANG="pl_PL.UTF-8"

# This will be used as the value
# for LC_MESSAGES in /etc/locale.conf
LOCALE_MSG="en_US.UTF-8"

# Setting the correct time zone
# All available values for AREA are
# in the /usr/share/zoneinfo/
# and for the location look
# in /usr/share/zoneinfo/AREA/
AREA="Europe"
LOCATION="Warsaw"

# My host and user names :)P
USERNAME="coffee"
HOSTNAME="machine"

# WARNING: Do not share this file with anyone
# and do not keep your password here. Set this
# variable only in live iso and remove it immediately
# after instalation
PASSWORD=""
ROOT_PASSWD=""

WALLPAPER="river_forrest.jpg"

# This is very "tape and glue"
# so be cautious.

# DISK_DEV should contain your
# hard drive device path as 
# seen from the live iso
DISK_DEV="/dev/sda"

# PART_PREF is the name
# of your partition device
# path without its number 
# (i.e /dev/nvme0n1p or /dev/sda)
PART_PREF="/dev/sda"

# Defines swap partition's size.
# The partition starts at 3MiB,
# because bios_grub ends at 3MiB,
# so you choose the size and add
# 3MiB to get the value. The rest
# of the disk is assigned to the 
# system partition. Note, this value
# cannot be less than 513MiB on UEFI
# systems and 3MiB on BIOS machines
SWAP_END="4099MiB"

# Set the system partition size
SYSPART_END="69635MiB"

# You need to specify the network
# only if you don't have Ethernet
# plugged in. If the network is 
# detected, then those options
# are ignored
SSID=""

# Please, be careful and do NOT
# share this file with PASSPHRASE
# and potentially other credentials
# filled
PASSPHRASE=""

# Your wireless network interface
# (usually wlan0 or enp0s3)
NETIF=""

BASE=(
	base base-devel linux linux-firmware sudo
	zsh networkmanager neovim python git
	man-db man-pages texinfo intel-ucode
)

INSTALL=(
	parted cups brlaser brother-dcp-l2530dw
	system-config-printer blueman bluez-utils
	alsa-utils pipewire-alsa pipewire-jack
	pipewire-pulse wireplumber dnsmasq fail2ban
	bridge-utils iptables-nft network-manager-applet
	networkmanager ufw dunst libvirt qemu-full
	virt-manager brightnessctl dmenu nodejs
	npm bat btop clang eza fzf gdb ghostty git
	github-cli neovim luarocks qalculate-gtk
	zoxide yazi ripgrep 7zip unzip
	wget zip cliphist eog fuzzel grim hypridle
	hyprland hyprlock hyprpaper mpv brave-bin
	nwg-look polkit-kde-agent qt6ct thunar spotify
	slurp wl-clipboard xdg-desktop-portal-hyprland
	waybar python-gobject wallust-git otf-font-awesome
	papirus-icon-theme moka-icon-theme-git
	arc-icon-theme-git bibata-cursor-theme
	breeze-gtk seer-gdb ttf-jetbrains-mono-nerd 
)
