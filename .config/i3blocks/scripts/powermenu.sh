#!/bin/sh

. $(dirname $0)/vars.sh

echo "$POWER_ICON"
echo "$POWER_ICON"
echo "#dddddd"

[ "$button" = "1" ] && systemctl suspend # && rofi -show window
