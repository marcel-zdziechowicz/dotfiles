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

(
	while true; do
		echo "$PASSWORD" | sudo -S true
		sleep 60
	done
) &
SUDO_LOOP_PID=$!
trap "kill $SUDO_LOOP_PID" EXIT

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -sic --noconfirm
cd ..
rm -rf yay-bin

yes | sudo pacman -Syu "${PACMAN_PKGS[@]}"
ARGS=(--noconfirm --answerdiff None 
	--answerclean None --useask
	--mflags "--noconfirm --skippgpcheck"
)
yes | yay -Sy "${AUR_PKGS[@]}" "${ARGS[@]}"
