#!/bin/bash
set -euo pipefail

source ~/dotfiles/variables.sh

sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
mcli device wifi connect "$SSID" password "$PASSPHRASE"
