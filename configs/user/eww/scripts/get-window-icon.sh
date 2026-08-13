#!/usr/bin/env bash

resolve_icon() {
    local icon="$1"

    # fallback icon jeśli brak
    local fallback_icon="application-x-executable"

    [ -z "$icon" ] && icon="$fallback_icon"

    [[ "$icon" == /* ]] && {
        echo "$icon"
        return
    }

    for p in \
        "/usr/share/icons/Papirus/48x48/apps/$icon.svg" \
        "/usr/share/icons/Papirus/48x48/apps/$icon.png" \
        "/usr/share/icons/hicolor/48x48/apps/$icon.png" \
        "/usr/share/icons/hicolor/48x48/apps/$icon.svg" \
        "/usr/share/icons/hicolor/scalable/apps/$icon.svg"
    do
        [ -f "$p" ] && echo "$p" && return
    done

    # FINAL FALLBACK (zawsze coś zwróci)
    for p in \
        "/usr/share/icons/hicolor/48x48/apps/$fallback_icon.png" \
        "/usr/share/icons/hicolor/48x48/apps/$fallback_icon.svg" \
        "/usr/share/icons/Papirus/48x48/apps/$fallback_icon.svg"
    do
        [ -f "$p" ] && echo "$p" && return
    done

    # absolutny last resort (nigdy nie puste)
    echo "/usr/share/icons/hicolor/48x48/apps/application-x-executable.png"
}

find_desktop() {
    local q="$1"
    local file wm exec name

    # 1. exact StartupWMClass (NAJWAŻNIEJSZE)
    while read -r file; do
        wm=$(grep -m1 '^StartupWMClass=' "$file" 2>/dev/null | cut -d= -f2)

        [[ -n "$wm" && "${wm,,}" == "${q,,}" ]] && {
            echo "$file"
            return
        }
    done < <(find /usr/share/applications ~/.local/share/applications -name "*.desktop" 2>/dev/null)

    # 2. Exec match (Brave FIX lives here)
    while read -r file; do
        exec=$(grep -m1 '^Exec=' "$file" 2>/dev/null | cut -d= -f2)

        [[ -n "$exec" && "${exec,,}" == *"${q,,}"* ]] && {
            echo "$file"
            return
        }
    done < <(find /usr/share/applications ~/.local/share/applications -name "*.desktop" 2>/dev/null)

    # 3. Name match
    while read -r file; do
        name=$(grep -m1 '^Name=' "$file" 2>/dev/null | cut -d= -f2)

        [[ -n "$name" && "${name,,}" == *"${q,,}"* ]] && {
            echo "$file"
            return
        }
    done < <(find /usr/share/applications ~/.local/share/applications -name "*.desktop" 2>/dev/null)
}

hyprctl clients -j |
jq -r '
  .[]
  | [.address, (.initialClass // .class // .title)]
  | select(.[1] != null and .[1] != "")
  | @tsv
' |
while IFS=$'\t' read -r address class; do
    desktop=$(find_desktop "$class")

    [ -z "$desktop" ] && continue

    name=$(grep -m1 '^Name=' "$desktop" | cut -d= -f2)
    icon=$(grep -m1 '^Icon=' "$desktop" | cut -d= -f2)

    icon_path=$(resolve_icon "$icon")

    [ -z "$name" ] && continue

	printf '{"name":"%s","icon":"%s","address":"%s"}\n' \
    "$name" "$icon_path" "$address"
done | jq -s '.'
