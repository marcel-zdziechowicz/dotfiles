#!/usr/bin/env bash
set -euo pipefail

source ~/dotfiles/scripts/variables.sh

sudo sed -i 's|^[#[:space:]]*\(default_options=.*\)|\1|' /etc/mkinitcpio.d/linux.preset
sudo mkinitcpio -P

# Point zsh at $XDG_CONFIG_HOME/zsh before it reads any
# user file. /etc/zsh/zshenv is the only startup file zsh
# sources before ZDOTDIR is consulted, so this is what
# lets us drop ~/.zshrc entirely and keep $HOME clean.
sudo mkdir -p /etc/zsh
cat <<'EOF' | sudo tee /etc/zsh/zshenv >/dev/null
# Managed by dotfiles/scripts/arch/sys-conf.sh
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
EOF

GRUB_PATH="/etc/default/grub"
sudo sed -i 's/^DEFAULT_TIMEOUT=.*/DEFAULT_TIMEOUT=0/' "$GRUB_PATH"
sudo sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/' "$GRUB_PATH"
sudo grub-mkconfig -o /boot/grub/grub.cfg

SSHD_PATH="/etc/ssh/sshd_config"
sudo sed -i 's/^[#[:space:]]*PermitRootLogin.*/PermitRootLogin no/' "$SSHD_PATH"
sudo sed -i 's/^[#[:space:]]*PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD_PATH"
sudo sed -i 's/^[#[:space:]]*PermitEmptyPasswords.*/PermitEmptyPasswords no/' "$SSHD_PATH"
sudo sed -i 's/^[#[:space:]]*MaxAuthTries.*/MaxAuthTries 3/' "$SSHD_PATH"
sudo sed -i 's/^[#[:space:]]*MaxSessions.*/MaxSessions 2/' "$SSHD_PATH"
sudo sed -i 's/^[#[:space:]]*KbdInteractiveAuthentication.*/KbdInteractiveAuthentication no/' "$SSHD_PATH"
