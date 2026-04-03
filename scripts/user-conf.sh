#!/bin/bash
set -euo pipefail

source ~/dotfiles/variables.sh

ln -sf ~/dotfiles/configs/user/zsh/.zshrc ~/.zshrc

rm -rf ~/.config/hypr
ln -s ~/dotfiles/configs/user/hypr ~/.config/hypr

rm -rf ~/.config/nvim
ln -s ~/dotfiles/configs/user/nvim ~/.config/nvim

rm -rf ~/.config/ghostty
ln -s ~/dotfiles/configs/user/ghostty	~/.config/ghostty

rm -rf ~/.config/dunst
ln -s ~/dotfiles/configs/user/dunst	~/.config/dunst

rm -rf ~/.config/fuzzel/
ln -s ~/dotfiles/configs/user/fuzzel ~/.config/fuzzel

rm -rf ~/.config/waybar
ln -s ~/dotfiles/configs/user/waybar ~/.config/waybar

rm -rf ~/.config/wallust
ln -s ~/dotfiles/configs/user/wallust	~/.config/wallust

rm -rf ~/.config/spicetify
ln -s ~/dotfiles/configs/user/spicetify	~/.config/spicetify

rm -rf ~/.config/gtk-4.0
ln -s ~/dotfiles/configs/user/gtk-4.0	~/.config/gtk-4.0

rm -rf ~/.config/gtk-3.0
ln -s ~/dotfiles/configs/user/gtk-3.0	~/.config/gtk-3.0

WALLPAPER_PATH="~/dotfiles/wallpapers/${WALLPAPER}"
wallust run "$WALLPAPER_PATH"
