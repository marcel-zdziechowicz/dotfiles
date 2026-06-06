#!/usr/bin/env bash
set -euo pipefail

source ~/dotfiles/scripts/variables.sh

ln -sf ~/dotfiles/configs/user/zsh/.zshrc ~/.zshrc

rm -rf ~/.config/hypr
ln -s ~/dotfiles/configs/user/hypr ~/.config/hypr

rm -rf ~/.config/nvim
ln -s ~/dotfiles/configs/user/nvim ~/.config/nvim

rm -rf ~/.config/ghostty
ln -s ~/dotfiles/configs/user/ghostty	~/.config/ghostty

rm -rf ~/.config/dunst
ln -s ~/dotfiles/configs/user/dunst	~/.config/dunst

rm -rf ~/.config/fuzzel
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

rm -rf ~/.config/zathura
ln -s ~/dotfiles/configs/user/zathura ~/.config/zathura

# Spicetify config
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

# After you log in to your spotify account
# run: spicetify backup apply

# Associate file types with proper applications
IMG_APP="org.gnome.eog.desktop"
PDF_APP="mupdf.desktop"
VID_APP="mpv.desktop"
AUD_APP="mpv.desktop"
ARC_APP="org.gnome.FileRoller.desktop"

xdg-mime default "$PDF_APP" application/pdf
xdg-mime default "$PDF_APP" application/epub+zip
xdg-mime default "$PDF_APP" application/x-mobipocket-ebook
xdg-mime default "$PDF_APP" application/vnd.djvu

xdg-mime default "$ARC_APP" application/zip
xdg-mime default "$ARC_APP" application/zstd
xdg-mime default "$ARC_APP" application/x-zstd
xdg-mime default "$ARC_APP" application/x-xz
xdg-mime default "$ARC_APP" application/x-tar
xdg-mime default "$ARC_APP" application/x-rar
xdg-mime default "$ARC_APP" application/x-gzip
xdg-mime default "$ARC_APP" application/x-bzip2
xdg-mime default "$ARC_APP" application/x-7z-compressed

xdg-mime default "$IMG_APP" image/png
xdg-mime default "$IMG_APP" image/jpeg
xdg-mime default "$IMG_APP" image/webp
xdg-mime default "$IMG_APP" image/gif
xdg-mime default "$IMG_APP" image/bmp
xdg-mime default "$IMG_APP" image/svg+xml
xdg-mime default "$IMG_APP" image/tiff
xdg-mime default "$IMG_APP" image/avif

xdg-mime default "$VID_APP" video/mp4
xdg-mime default "$VID_APP" video/x-matroska
xdg-mime default "$VID_APP" video/webm
xdg-mime default "$VID_APP" video/x-msvideo
xdg-mime default "$VID_APP" video/quicktime
xdg-mime default "$VID_APP" video/3gpp
xdg-mime default "$VID_APP" video/mpeg
xdg-mime default "$VID_APP" video/ogg

xdg-mime default "$AUD_APP" audio/mp4
xdg-mime default "$AUD_APP" audio/flac
xdg-mime default "$AUD_APP" audio/wav
xdg-mime default "$AUD_APP" audio/aac
xdg-mime default "$AUD_APP" audio/mpeg
xdg-mime default "$AUD_APP" audio/ogg

WALLPAPER_PATH=~/dotfiles/wallpapers
wallust run "${WALLPAPER_PATH}/${WALLPAPER}"
