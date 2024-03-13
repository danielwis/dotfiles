#!/bin/sh

screenshots_dir="$HOME/Pictures/screenshots/"
datestring=$(date +%FT%T_%N)
filename="${screenshots_dir}/${datestring}.png"

if [ $# -lt 1 ]; then
  echo "Usage: $0 (full|copy)"
  exit 1
fi

case "$1" in
  "full")
    grim "$filename" && notify-send "Screenshot taken!" "Saved as $filename"
    ;;
  "copy")
    # TODO: make this exit without notification if escaped
    grim -g "$(slurp)" - | wl-copy && notify-send "Screenshot taken!" "Saved to clipboard"
    ;;
  *)
    echo "Expected 'full' or 'copy', got $1"
    ;;
esac
