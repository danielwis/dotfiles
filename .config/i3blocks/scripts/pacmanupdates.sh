#!/bin/sh

. $(dirname $0)/vars.sh

# Sync updates, quietly
sudo pacman -Syq > /dev/null
# Get update count
pacman -Qu | wc -l > update_tmp
UPDATE_COUNT=$(cat update_tmp)

echo "$UPDATES_ICON $UPDATE_COUNT"
echo "$UPDATES_ICON $UPDATE_COUNT"

[ "$UPDATE_COUNT" -lt "5" ] && echo "$PASTEL_GREEN" && exit
[ "$UPDATE_COUNT" -lt "15" ] && echo "$PASTEL_YELLOW" && exit
echo "$PASTEL_RED" && exit
