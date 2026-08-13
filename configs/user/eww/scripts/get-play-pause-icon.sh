#!/usr/bin/env bash
set -euo pipefail

if [[ "$(playerctl metadata --format '{{status}}')" == "Playing" ]]; then
    echo "󰏤"
else
    echo "󰐊"
fi
