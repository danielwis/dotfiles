#!/bin/sh

. $(dirname $0)/vars.sh

# Sync updates, quietly.
# Requires having
# [username] ALL=(ALL) NOPASSWD:/usr/bin/pacman -Syq
# in the sudoers file (sudo EDITOR=vim visudo)
sudo pacman -Syq > /dev/null
# Get update count
UPDATE_COUNT=$(pacman -Qu | wc -l)

echo "$UPDATES_ICON $UPDATE_COUNT"
echo "$UPDATES_ICON $UPDATE_COUNT"

if [ "$button" = "1" ]; then
    [ "$UPDATE_COUNT" = "0" ] && notify-send "No updates available" || notify-send "Updates available" "$(pacman -Qu)"
fi

[ "$UPDATE_COUNT" -lt "5" ] && echo "$PASTEL_GREEN" && exit
[ "$UPDATE_COUNT" -lt "15" ] && echo "$PASTEL_YELLOW" && exit
echo "$PASTEL_RED" && exit
