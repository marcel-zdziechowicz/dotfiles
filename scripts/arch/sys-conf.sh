#!/usr/bin/env bash
set -euo pipefail

source ~/dotfiles/scripts/variables.sh

sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
