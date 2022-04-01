#!/bin/sh

. $(dirname $0)/vars.sh

# Sync updates, quietly.
# Requires having
# [username] ALL=(ALL) NOPASSWD:/usr/bin/pacman -Syq
# in the sudoers file (sudo EDITOR=vim visudo)
sudo pacman -Syq > /dev/null
# Get update count
pacman -Qu | wc -l > update_tmp
UPDATE_COUNT=$(cat update_tmp)

echo "$UPDATES_ICON $UPDATE_COUNT"
echo "$UPDATES_ICON $UPDATE_COUNT"

if [ "$button" = "1" ]; then
    notify-send "Updates available" "$(pacman -Qu)"
fi

[ "$UPDATE_COUNT" -lt "5" ] && echo "$PASTEL_GREEN" && exit
[ "$UPDATE_COUNT" -lt "15" ] && echo "$PASTEL_YELLOW" && exit
echo "$PASTEL_RED" && exit
