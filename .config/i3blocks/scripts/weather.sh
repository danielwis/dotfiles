#!/bin/sh

. $(dirname $0)/vars.sh

WEATHER=$(curl -s wttr.in/?format="%C\n")
[ "$WEATHER" == "Overcast" ] && echo "$WEATHER_ICON_CLOUDY " && exit 0
[ "$WEATHER" == "Clear" ] && echo $WEATHER_ICON_SUNNY && echo $WEATHER_ICON_SUNNY && echo $PASTEL_YELLOW && exit 0
# TODO
[ "$WEATHER" == "Partly cloudy" ] && echo "$WEATHER_ICON_PARTLY_CLOUDY " && exit 0
# [ "$WEATHER" == "Clear" ] && echo $WEATHER_ICON_SUNNY && echo $WEATHER_ICON_SUNNY && echo "#FFFF00" && exit 0
[ "$WEATHER" == "Overcast" ] && echo $WEATHER_ICON_CLOUDY && exit 0
[ "$WEATHER" == "Overcast" ] && echo $WEATHER_ICON_CLOUDY && exit 0

# If not recognized
echo "$WEATHER not recognized" && echo "" && exit 33
