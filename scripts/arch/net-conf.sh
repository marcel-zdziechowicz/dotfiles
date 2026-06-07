#!/usr/bin/env bash
set -euo pipefail
source ~/dotfiles/scripts/variables.sh

sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo systemctl enable --now NetworkManager
sudo systemctl disable NetworkManager-wait-online.service
sudo systemctl enable --now systemd-resolved
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

sudo mkdir -p /etc/systemd/resolved.conf.d
cat <<EOF | sudo tee /etc/systemd/resolved.conf.d/dns.conf >/dev/null
[Resolve]
DNS=${DNS_PRIMARY} ${DNS_SECONDARY}
DNSSEC=allow-downgrade
DNSOverTLS=yes
EOF

sudo systemctl restart systemd-resolved

nmcli device wifi connect "$SSID" password "$PASSPHRASE" name "$SSID"
nmcli connection modify "$SSID" \
	ipv4.ignore-auto-dns yes \
	ipv6.ignore-auto-dns yes

nmcli connection down "$SSID" || true
nmcli connection up "$SSID"
