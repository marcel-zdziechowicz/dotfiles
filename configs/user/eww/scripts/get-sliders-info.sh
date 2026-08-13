#!/usr/bin/env bash

# ===== BATTERY (fallback = 100%) =====
if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
    battery=$(< /sys/class/power_supply/BAT0/capacity)
    status=$(< /sys/class/power_supply/BAT0/status)

    if [[ "$status" == "Charging" ]]; then
        battery_icon="󰂄"
    else
        case $battery in
            9[0-9]|100) battery_icon="󰁹" ;;
            8[0-9])      battery_icon="󰂂" ;;
            7[0-9])      battery_icon="󰂁" ;;
            6[0-9])      battery_icon="󰂀" ;;
            5[0-9])      battery_icon="󰁿" ;;
            4[0-9])      battery_icon="󰁾" ;;
            3[0-9])      battery_icon="󰁽" ;;
            2[0-9])      battery_icon="󰁼" ;;
            1[0-9])      battery_icon="󰁻" ;;
            *)           battery_icon="󰁺" ;;
        esac
    fi
else
    battery=100
    battery_icon="󰁹"
fi

# ===== VOLUME =====
vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
volume=$(awk '{printf "%d", $2*100}' <<< "$vol_raw")

if grep -q MUTED <<< "$vol_raw"; then
    volume=0
    volume_icon="󰖁"
elif (( volume == 0 )); then
    volume_icon="󰖁"
elif (( volume < 35 )); then
    volume_icon="󰕿"
elif (( volume < 70 )); then
    volume_icon="󰖀"
else
    volume_icon="󰕾"
fi

# ===== BRIGHTNESS =====
brightness=$(brightnessctl -m 2>/dev/null | cut -d',' -f4 | tr -d '%')

if [[ -z "$brightness" ]]; then
    brightness=100
    brightness_icon="󰃠"
elif (( brightness < 30 )); then
    brightness_icon="󰃞"
elif (( brightness < 70 )); then
    brightness_icon="󰃟"
else
    brightness_icon="󰃠"
fi

# ===== JSON OUTPUT =====
printf '{"battery":{"percent":%d,"icon":"%s"},"volume":{"percent":%d,"icon":"%s"},"brightness":{"percent":%d,"icon":"%s"}}\n' \
    "$battery" "$battery_icon" \
    "$volume" "$volume_icon" \
    "$brightness" "$brightness_icon"
