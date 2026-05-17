#!/usr/bin/env bash
set -euo pipefail

source ~/dotfiles/scripts/variables.sh

sudo systemctl enable --now NetworkManager
echo "Sleeping for 5 seconds so NetworkManager can start properly..."
sleep 5
sudo nmcli device wifi connect "$SSID" password "$PASSPHRASE"

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -sic --noconfirm
cd ..
rm -rf yay-bin

ARGS=(--noconfirm --answerdiff None 
	--answerclean None --useask
	--mflags "--noconfirm" --sudoloop
)

if ! yay -S "${ARGS[@]}" "${INSTALL[@]}"; then
	echo "I just fucking wanted to install packages..."
fi

# Install spicetify
# curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
