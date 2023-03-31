#!/bin/sh

# TODO: Extend this to be not just PDF reading

# Exclude .local path and find all files ending in ".pdf", then pipe to rofi's dmenu-style thingy with the prompt being "Open PDF"
file=$(find ~ -type f -name "*.pdf" -not -path '*/.local/*' | sed -r 's/\/([^\/]+\/)*//g' | rofi -dmenu -matching regex -p "Open PDF")
filepath=$(find ~ -type f -name "$file")
echo $filepath
if [ -z $filepath ]; then
    exit
else
    zathura $filepath &
    notify-send "Success" "Associated $file with $filepath and opened it in Zathura"
fi
