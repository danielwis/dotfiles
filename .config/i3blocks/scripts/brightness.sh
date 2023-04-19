#!/bin/bash

# Source variables
. $(dirname $0)/vars.sh

CURR_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/brightness)
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
BRIGHTNESS_PCT=`expr 100 \* $CURR_BRIGHTNESS / $MAX_BRIGHTNESS`

echo "󰖨 $BRIGHTNESS_PCT%" && echo "󰖨 $BRIGHTNESS_PCT%" && echo "$PASTEL_YELLOW"
