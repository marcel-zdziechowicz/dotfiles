#!/bin/bash
set -euo pipefail

source ~/dotfiles/variables.sh

sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
