#!/usr/bin/env bash
set -euo pipefail

source ~/dotfiles/scripts/variables.sh

if ! doas pkg_add "${OPENBSD_PKGS[@]}"; then
	echo "C'mon, install this fucking software!"
fi
