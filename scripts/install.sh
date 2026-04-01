#!/bin/bash
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SOURCE_DIR}/../variables.sh"

PACMAN_PKGS=()
AUR_PKGS=()

for pkg in "${INSTALL[@]}"; do
	if pacman -Si "$pkg" &>/dev/null; then
		PACMAN_PKGS+=("$pkg")
	else
		AUR_PKGS+=("$pkg")
	fi
done

(
	while true; do
		echo "$PASSWORD" | sudo -S true
		sleep 60
	done
) &
SUDO_LOOP_PID=$!
trap "kill $SUDO_LOOP_PID" EXIT

pwd

# pacman -Syu --noconfirm "${PACMAN_PKGS[@]}"
# yay -S  --noconfirm --answerdiff None --answerclean None
