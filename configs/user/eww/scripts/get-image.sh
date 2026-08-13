#!/usr/bin/env bash
set -euo pipefail

# /usr/share/icons/breeze/mimetypes/16/audio-ogg.svg
fallback="/usr/share/icons/breeze/mimetypes/16/audio-ogg.svg"

url="$(playerctl metadata mpris:artUrl 2>/dev/null || true)"

# jeśli brak URL → fallback
if [[ -z "${url:-}" ]]; then
  echo "$fallback"
  exit 0
fi

case "$url" in
  file://*)
    echo "${url#file://}"
    ;;
  http*|https*)
    path="$(mktemp)"
    curl -fsSL "$url" -o "$path" || {
      rm -f "$path"
      echo "$fallback"
      exit 0
    }
    echo "$path"
    ;;
  *)
    echo "$fallback"
    ;;
esac
