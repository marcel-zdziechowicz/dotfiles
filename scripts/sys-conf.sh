#!/bin/bash
set -euo pipefail

source "/home/${USERNAME}/dotfiles/variables.sh"

systemctl enable NetworkManager
systemctl start NetworkManager
nmcli "$NETIF" wifi connect "$SSID" password "$PASSPHRASE"
