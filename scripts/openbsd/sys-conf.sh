#!/usr/bin/env bash

source ~/dotfiles/scripts/variables.sh
NETCONF_PATH="/etc/hostname.${NETIF}"

doas tee "$NETCONF_PATH" > /dev/null <<EOF
join "$SSID" wpakey "$PASSPHRASE"
inet autoconf
EOF
