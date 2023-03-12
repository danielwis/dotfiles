#!/bin/bash

# Original Command
# command=echo "  `iwctl station wlan0 show | grep "Connected network" | sed 's/\s*Connected network\s*//' | sed 's/\s*$//g'` (`awk 'NR==3 {print $3}' /proc/net/wireless | sed 's/\.$/%/' | sed 's/[\r\n]//g'`)"


. $(dirname $0)/vars.sh

[ "$button" = "1" ] && ~/scripts/wifi.sh

# Create temp file for storing variables (no better way???)
echo "`iwctl station wlan0 show | grep "Connected network" | sed 's/\s*Connected network\s*//' | sed 's/\s*$//g'`" > wifi_tmp
echo "`awk 'NR==3 {print $3}' /proc/net/wireless | sed 's/\.$//' | sed 's/[\r\n]//g'`" >> wifi_tmp

# FOR ROFI WIFI MENU - Lists all networks (searches for 2 or more spaces to determine end of network name)
# Remember to start by scanning
# iwctl station wlan0 get-networks | tail -4 | sed 's/\s*//' | sed 's/.*>\s//' | sed 's/\s\{2,\}.*//'

# Get status variables
WIFI_NAME=$(head -n 1 wifi_tmp)
WIFI_SIG_STR=$(tail -n 1 wifi_tmp)
# Normalise wifi signal strength as max is set by driver (in this laptop's case, 70)
WIFI_MAX_SIG_STR=70
WIFI_NORM_SIG_STR=`expr 100 \* $WIFI_SIG_STR / $WIFI_MAX_SIG_STR`

# Print "no signal/down" and exit if no wifi
[ "$WIFI_NAME" == "" ] && echo "  No signal" && echo "  Down" && echo $PASTEL_RED && exit 0

# Full text
echo "  $WIFI_NAME ($WIFI_NORM_SIG_STR%)"
# Short text
echo "  $WIFI_NORM_SIG_STR%"

if [ $WIFI_NORM_SIG_STR -ge 75 ]; then
    echo $PASTEL_GREEN
elif [ $WIFI_NORM_SIG_STR -ge 50 ]; then
    echo $PASTEL_YELLOW
else
    echo $PASTEL_RED
fi

# Remove temp file
rm wifi_tmp

exit 0
