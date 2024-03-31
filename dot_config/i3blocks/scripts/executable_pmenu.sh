#!/bin/sh

. $(dirname $0)/vars.sh

echo "$POWER_ICON"
echo "$POWER_ICON"
echo "#dddddd"

if [ "$button" = "1" ]; then
    uptime=$(uptime -p | sed 's/up //g')
    usr="Daniel"
    shutdown=" Shutdown"
    reboot=" Reboot"
    suspend=" Suspend"
    lock=" Lock"
    logout="󰍃 Log out"

    options=$(echo "$lock\n$suspend\n$logout\n$reboot\n$shutdown")

    action=$(echo -e $options | tofi --prompt-text "..." --height "36%" --font-size 36)

    case $action in
        $shutdown)
            systemctl poweroff
            ;;
        $reboot)
            systemctl reboot
            ;;
        $suspend)
            systemctl suspend
            ;;
        $lock)
            swaylock -f
            ;;
        $logout)
            i3-msg exit
            ;;
    esac
fi
