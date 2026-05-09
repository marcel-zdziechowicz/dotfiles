#!/bin/bash
set -euo pipefail

# Restore password prompts
sudo sed -i 's/^%wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Remove sensitive data from variables.sh
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAR_PATH="${SOURCE_DIR}/variables.sh"
sudo sed -i 's/^PASSWORD=".*"/PASSWORD=""/' "$VAR_PATH"
sudo sed -i 's/^ROOT_PASSWD=".*"/ROOT_PASSWD=""/' "$VAR_PATH"
sudo sed -i 's/^SSID=".*"/SSID=""/' "$VAR_PATH"
sudo sed -i 's/^PASSPHRASE=".*"/PASSPHRASE=""/' "$VAR_PATH"
