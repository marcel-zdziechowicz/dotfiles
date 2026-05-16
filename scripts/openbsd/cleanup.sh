#!/usr/bin/env bash
set -euo pipefail

# Remove sensitive data from variables.sh
VAR_PATH=~/dotfiles/scripts/variables.sh
sed -i 's/^PASSWORD=".*"/PASSWORD=""/' "$VAR_PATH"
sed -i 's/^ROOT_PASSWD=".*"/ROOT_PASSWD=""/' "$VAR_PATH"
sed -i 's/^SSID=".*"/SSID=""/' "$VAR_PATH"
sed -i 's/^PASSPHRASE=".*"/PASSPHRASE=""/' "$VAR_PATH"
