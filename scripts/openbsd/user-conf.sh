#!/usr/bin/env bash
DOTCONF=~/dotfiles/configs/user

mkdir ~/.config

rm ~/.xinitrc
ln -s "${DOTCONF}/x11/.xinitrc" ~/.xinitrc

rm ~/.i3status.conf
ln -s "${DOTCONF}/i3/.i3status.conf" ~/.i3status.conf

rm -rf ~/.config/i3
ln -s "${DOTCONF}/i3" ~/.config/i3

rm -rf ~/.config/dunst
ln -s "${DOTCONF}/dunst" ~/.config/dunst

rm -rf ~/.config/kitty/
ln -s "${DOTCONF}/kitty" ~/.config/kitty

rm -rf ~/.config/nvim
ln -s "${DOTCONF}/nvim" ~/.config/nvim
