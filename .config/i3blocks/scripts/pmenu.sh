#!/bin/sh

. $(dirname $0)/vars.sh

echo "$POWER_ICON"
echo "$POWER_ICON"
echo "#dddddd"

if [ "$button" = "1" ]; then
    uptime=$(uptime -p | sed 's/up //g')
    usr="Daniel"
    shutdown=""
    reboot=""
    suspend=""
    lock=""
    logout="󰍃"

    options=$(echo "$lock\n$suspend\n$logout\n$reboot\n$shutdown")

    action=$(echo -e $options | rofi \
        -dmenu \
        -p "Goodbye, $usr" \
        -mesg "Uptime: $uptime" \
        -theme powermenu.rasi)

    case $action in
        $shutdown)
            systemctl poweroff
            ;;
        $reboot)
            systemctl reboot
            ;;
        $suspend)
            ~/.config/i3blocks/scripts/lock.sh
            systemctl suspend
            ;;
        $lock)
            ~/.config/i3blocks/scripts/lock.sh
            ;;
        $logout)
            i3-msg exit
            ;;
    esac
fi
