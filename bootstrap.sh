#!/bin/bash
set -euo pipefail

chmod +x ./variables.sh
chmod +x ./scripts/live-iso-conf.sh
./scripts/live-iso-conf.sh

arch-chroot /mnt chmod +x "/home/${USERNAME}/dotfiles/install.sh"
INSTALL_PATH="/home/${USERNAME}/dotfiles/scripts/install.sh"
arch-chroot /mnt sudo -u "$USERNAME" "$INSTALL_PATH"
