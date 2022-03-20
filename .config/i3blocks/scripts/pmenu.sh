#!/bin/sh

. $(dirname $0)/vars.sh

echo "$POWER_ICON"
echo "$POWER_ICON"
echo "#dddddd"

if [ "$button" = "1" ]; then
    uptime=$(uptime -p | sed 's/up //g')
    shutdown=""
    reboot=""
    lock=""

    options=$(echo "$lock\n$reboot\n$shutdown")

    action=$(echo -e $options | rofi \
        -dmenu \
        -p "Uptime: $uptime" \
        -theme powermenu.rasi)

    case $action in
        $shutdown)
            systemctl poweroff
            ;;
        $reboot)
            systemctl reboot
            ;;
        $lock)
            ~/.config/i3blocks/scripts/lock.sh
            ;;
    esac
fi
