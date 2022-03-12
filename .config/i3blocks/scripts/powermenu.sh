#!/bin/sh

. $(dirname $0)/vars.sh

echo "$POWER_ICON"
echo "$POWER_ICON"
echo "#dddddd"

i3lock_cmd=$(cat ./lockscreen)

if [ "$button" = "1" ]; then
    i3lock \
        --blur=5 \
        -k \
        --indicator \
        --ring-width 5 \
        --ring-color=ffffff88 \
        --ringver-color=ffffff88 \
        --ringwrong-color=ff222255 \
        --inside-color=ffffff00 \
        --insidever-color=cccccc00 \
        --insidewrong-color=ffffff00 \
        --keyhl-color=cccccc90 \
        --time-color=ccccccdd \
        --date-color=ccccccdd \
        --date-str="%a, %d %b %Y" \
        --line-uses-inside \
        --verif-text="..." \
        --verif-color=ccccccdd \
        --wrong-text="" \
        --greeter-text="Type password to unlock" \
        --greeter-pos="ix:550" \
        --greeter-color=ccccccdd \
        -e

    systemctl suspend # && rofi -show window
fi
