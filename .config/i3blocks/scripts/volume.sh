#!/bin/sh

. $(dirname $0)/vars.sh

SOUND_STATUS=$(amixer get Master | grep '\[o'  | awk '{print $6}' | sed 's/\]//' | sed 's/\[//' | head -n 1)

if [ "$button" = "1" ]; then
    # Mute/unmute
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    SOUND_STATUS=$(amixer get Master | grep '\[o'  | awk '{print $6}' | sed 's/\]//' | sed 's/\[//' | head -n 1)
    [ "$SOUND_STATUS" = "off" ] && notify-send "Volume muted" || notify-send "Volume unmuted"
fi

VOLUME=$(amixer sget Master | awk '{print $5}' | grep "\[" | sed 's/\[//g' | sed 's/%\]//' |head -n 1)

[ "$SOUND_STATUS" = "on" ] && echo "$VOLUME_ICON $VOLUME%" && echo "$VOLUME_ICON $VOLUME%"
[ "$SOUND_STATUS" = "off" ] && echo "$VOLUME_ICON_MUTE $VOLUME%" && echo "$VOLUME_ICON_MUTE $VOLUME%"

[ "$VOLUME" -gt 100 ] && echo "$PASTEL_RED"

exit 0
