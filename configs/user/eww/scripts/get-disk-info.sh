#!/usr/bin/env bash
set -euo pipefail

root_src=$(findmnt -n -o SOURCE /)
disk=$(lsblk -no pkname "$root_src")

read used total <<< "$(
    df -BG --output=source,used,size | awk -v d="$disk" '
    NR>1 {
        src=$1
        used=$2
        total=$3

        cmd="lsblk -no pkname " src " 2>/dev/null"
        cmd | getline parent
        close(cmd)

        if (parent == d) {
            gsub("G","",used)
            gsub("G","",total)
            u+=used
            t+=total
        }
    }
    END {
        printf "%.0f %.0f", u, t
    }'
)"

pct=$(awk -v u="$used" -v t="$total" 'BEGIN {
    if (t==0) print "0%";
    else printf "%.0f", (u/t)*100
}')

cat <<EOF
{
  "disk": "$disk",
  "used_gb": $used,
  "total_gb": $total,
  "percent": "$pct"
}
EOF
