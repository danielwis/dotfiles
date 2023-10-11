#!/bin/sh

# Only one argument supported at the moment (inc, dec)
[ $# = 1 ] || exit 1

vol_threshold=50

curr_vol=$(amixer sget Master | awk -F"[][%]" '/Left:/ {print $2}')

case "$1" in
  "inc")
    [ "$curr_vol" -ge "$vol_threshold" ] && exit 1
    pactl set-sink-volume @DEFAULT_SINK@ +5% && pkill -SIGRTMIN+10 i3blocks
    ;;
  "dec")
    pactl set-sink-volume @DEFAULT_SINK@ -5% && pkill -SIGRTMIN+10 i3blocks
    ;;
  *)
    exit 1
    ;;
esac
