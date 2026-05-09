#!/bin/bash
set -euo pipefail

source ~/dotfiles/scripts/variables.sh

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
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
