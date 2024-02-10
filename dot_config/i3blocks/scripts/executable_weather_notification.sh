#!/bin/sh

. $(dirname $0)/vars.sh

WEATHER=$(curl -s 'wttr.in/?format=%l:+%C+(%t)\n')

notify-send "Weather" "$WEATHER"
