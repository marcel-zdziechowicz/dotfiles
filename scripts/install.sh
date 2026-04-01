#!/bin/bash
set -euo pipefail

cd ~/dotfiles
CURR_DIR="$(pwd)"
source "${CURR_DIR}/variables.sh"

PACMAN_PKGS=()
AUR_PKGS=()

for pkg in "${INSTALL[@]}"; do
	if pacman -Si "$pkg" &>/dev/null; then
		PACMAN_PKGS+=("$pkg")
	else
		AUR_PKGS+=("$pkg")
	fi
done

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -sic --noconfirm
cd ..
rm -rf yay-bin

pacman -Syu --noconfirm "${PACMAN_PKGS[@]}"
# yay -S  --noconfirm --answerdiff None --answerclean None
