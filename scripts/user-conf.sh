#!/bin/bash
set -euo pipefail

source ../variables.sh

ln -sf ../configs/user/zsh/.zshrc		~/.zshrc
ln -sf ../configs/user/hypr/				~/.config/hypr/
ln -sf ../configs/user/nvim/				~/.config/nvim/
ln -sf ../configs/user/ghostty/			~/.config/ghostty/
ln -sf ../configs/user/dunst/				~/.config/dunst/
ln -sf ../configs/user/fuzzel/			~/.config/fuzzel/
ln -sf ../configs/user/waybar/			~/.config/waybar/
ln -sf ../configs/user/wallust/			~/.config/wallust/
ln -sf ../configs/user/spicetify/		~/.config/spicetify/
ln -sf ../configs/user/gtk-4.0/			~/.config/gtk-4.0/
ln -sf ../configs/user/gtk-3.0/			~/.config/gtk-3.0/

WALLPAPER_PATH="../wallpapers/${WALLPAPER}"
wallust run "$WALLPAPER_PATH"
