#!/usr/bin/env bash
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
	exit 1
fi

ZSH_SUGGESTIONS="https://github.com/zsh-users/zsh-autosuggestions.git"
ZSH_COMPLETIONS="https://github.com/zsh-users/zsh-completions.git"
ZSH_SYNTAXHIGHLIGHT="https://github.com/zsh-users/zsh-syntax-highlighting"

sudo git clone "$ZSH_SUGGESTIONS" /usr/share/zsh/plugins/zsh-autosuggestions
sudo git clone "$ZSH_COMPLETIONS" /usr/share/zsh/plugins/zsh-completions
sudo git clone "$ZSH_SYNTAXHIGHLIGHT" /usr/share/zsh/plugins/zsh-syntax-highlighting

git clone https://github.com/elkowar/eww ~/.local/cache/eww
cd ~/.local/cache/eww
cargo build --release --no-default-features --features=wayland
cd target/release
chmod a+x ./eww
mkdir -p ~/.local/bin
cp ./eww ~/.local/bin/eww
