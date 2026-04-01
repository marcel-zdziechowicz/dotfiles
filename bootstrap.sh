#!/bin/bash
set -euo pipefail

chmod +x ./variables.sh
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SOURCE_DIR}/variables.sh"

chmod +x ./scripts/live-iso-conf.sh
./scripts/live-iso-conf.sh

arch-chroot /mnt chmod +x "/home/${USERNAME}/dotfiles/scripts/install.sh"
INSTALL_PATH="/home/${USERNAME}/dotfiles/scripts/install.sh"
arch-chroot /mnt sudo -u "$USERNAME" "$INSTALL_PATH"

# TODO: Remove NOPASSWD from /etc/sudoers
