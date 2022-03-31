#!/bin/sh

. $(dirname $0)/vars.sh

UPICON=""
DOWNICON=""
LOGFILE="/tmp/netlog"

CURRUP=$(cat /sys/class/net/eno1/statistics/tx_bytes)
CURRDOWN=$(cat /sys/class/net/eno1/statistics/rx_bytes)
PREVUP=$(head -n 1 $LOGFILE)
PREVDOWN=$(tail -n 1 $LOGFILE)
UP=$(echo "$CURRUP $PREVUP" | awk '{printf "%d", $1-$2}')
DOWN=$(echo "$CURRDOWN $PREVDOWN" | awk '{printf "%d", $1-$2}')

UP=$(echo $UP | awk '{printf "%.2f", $1 / (1024*10)}') # Avg. Mbps over 10 seconds
DOWN=$(echo $DOWN | awk '{printf "%.2f", $1 / (1024*10)}') # Avg. Mbps over 10 seconds

echo "$UPICON $UP $DOWNICON $DOWN"
echo "$UP/$DOWN"
echo $PASTEL_YELLOW

echo -e "$CURRUP\n$CURRDOWN" > $LOGFILE
