#!/bin/bash

. "$(dirname "$0")"/vars.sh

# Set these to something that makes sense for your machine
ifc=wlan0
WIFI_MAX_SIG_STR=70

if [ "$button" = "1" ]; then
  state=$(iwctl station "$ifc" show | rg State | awk '{print $2}')
  if [ "$state" = "disconnected" ]; then
    iwctl station "$ifc" scan
    notify-send "Wifi" "Scanning..." -t 3000
    notify-send "Available networks" "$(iwctl station "$ifc" get-networks)"
  else
    notify-send "WiFi stats" "$(iwctl station "$ifc" show | sed 's/\x1B\[[0-9;]*[JKmsu]//g' | tail -n +5 | head -n -1 | awk -F '  +' '{ print $2 ": " $3}')" -t 10000
  fi
fi

# Get status variables
WIFI_NAME=$(iwctl station "$ifc" show | grep "Connected network" | sed 's/\s*Connected network\s*//' | sed 's/\s*$//g')
WIFI_SIG_STR=$(awk 'NR==3 {print $3}' /proc/net/wireless | sed 's/\.$//' | sed 's/[\r\n]//g')
# Normalise wifi signal strength as max is set by driver
WIFI_NORM_SIG_STR=$(expr 100 \* "$WIFI_SIG_STR" / "$WIFI_MAX_SIG_STR")

# Print "no signal/down" and exit if no wifi
[ "$WIFI_NAME" == "" ] && echo "  No signal" && echo "  Down" && echo $PASTEL_RED && exit 0

# Full text
echo "  $WIFI_NAME ($WIFI_NORM_SIG_STR%)"
# Short text
echo "  $WIFI_NORM_SIG_STR%"

if [ "$WIFI_NORM_SIG_STR" -ge 75 ]; then
  echo $PASTEL_GREEN
elif [ "$WIFI_NORM_SIG_STR" -ge 50 ]; then
  echo $PASTEL_YELLOW
else
  echo $PASTEL_RED
fi

exit 0
