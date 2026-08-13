#!/usr/bin/env bash
set -euo pipefail

uptime=$(uptime -p | awk '{
    gsub("up ","");
    gsub(" days?","d");
    gsub(" hours?","h");
    gsub(" minutes?","m");
    print
}')

ping=$(ping -c 1 1.1.1.1 | awk -F'time=' '/time=/ {print $2}' | awk '{print $1}')
cpu_temp=$(sensors | awk '/Package id 0/ {print $4}' | head -n 1 | tr -d '+°C')
cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/ {print int(100 - $8)}')
ip=$(ip -4 addr show wlp0s29u1u6 | awk '/inet/ {print $2}' | cut -d/ -f1)
ram_usage=$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')
ram_info=$(free | awk '/Mem:/ {
    used=$3/1024/1024
    total=$2/1024/1024
    pct=int($3/$2*100)
    printf "%d%% (%d/%dGB)", pct, used, total
}')
gpu_temp=$(sensors | awk '/edge:/ {print $2}' | head -n 1 | tr -d '+°C')
gpu_usage=$(radeontop -d - -l 1 | awk -F',' '/gpu/ {gsub("gpu","",$2); print int($2)}')

kernel="$(uname -r | cut -d- -f1)"

echo "{\
\"uptime\":\"$uptime\",\
\"ping\":\"$ping\",\
\"ip\":\"$ip\",\
\"kernel\":\"$kernel\",\
\"cpu_temp\":$cpu_temp,\
\"cpu_usage\":$cpu_usage,\
\"ram_usage\":$ram_usage,\
\"ram_info\":\"$ram_info\",\
\"gpu_temp\":$gpu_temp,\
\"gpu_usage\":$gpu_usage\
}"
