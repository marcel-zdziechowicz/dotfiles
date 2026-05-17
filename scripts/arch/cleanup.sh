#!/usr/bin/env bash
set -euo pipefail

# Restore password prompts
SED_CMD='s/^%wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) ALL/'
sudo sed -i "$SED_CMD" /etc/sudoers

# Remove sensitive data from variables.sh
VAR_PATH=~/dotfiles/scripts/variables.sh
sed -i 's/^PASSWORD=".*"/PASSWORD=""/' "$VAR_PATH"
sed -i 's/^ROOT_PASSWD=".*"/ROOT_PASSWD=""/' "$VAR_PATH"
sed -i 's/^SSID=".*"/SSID=""/' "$VAR_PATH"
sed -i 's/^PASSPHRASE=".*"/PASSPHRASE=""/' "$VAR_PATH"
