#!/bin/bash

. $(dirname $0)/vars.sh

# Status
BAT=$(cat /sys/class/power_supply/BAT0/capacity)
MAX_CAPACITY=$(cat /sys/class/power_supply/BAT0/energy_full_design)
CURRENT_CAPACITY=$(cat /sys/class/power_supply/BAT0/energy_full)
CHARGING_STATUS=$(cat /sys/class/power_supply/BAT0/status)
RELATIVE_CAPACITY=`expr 100 \* $CURRENT_CAPACITY / $MAX_CAPACITY`
CURRENT_POWER_DRAW=$(awk '{print $1*10^-6 " W"}' /sys/class/power_supply/BAT0/power_now)

[ "$button" == "1" ] && notify-send "Battery status" "$CHARGING_STATUS (currently at $BAT%).\nCapacity: $CURRENT_CAPACITY/$MAX_CAPACITY ($RELATIVE_CAPACITY%).\nCurrent power draw: $CURRENT_POWER_DRAW."


# TODO? Change so colours are kept and only icon changes, or not?
if [ $CHARGING_STATUS == "Charging" ]; then
    # Charging
    echo " $BAT%"
    echo " $BAT%"

    [ $BAT == 100 ] && echo "#ff0000"
    [ $BAT -ne 100 ] && echo "#ffff00"
# Not charging
else
    [ "$CHARGING_STATUS" == "Full" ] && echo " $BAT%" && echo " $BAT%" && echo $PASTEL_GREEN && exit 0

    if [ $BAT -ge 75 ]; then # Check gt 90, 80 and then else for 75 -> 80
        if [ $BAT -gt 90 ]; then
            echo "$BATTERY_100 $BAT%"
            echo "$BATTERY_100 $BAT%"
        elif [ $BAT -gt 80 ]; then
            echo "$BATTERY_90 $BAT%"
            echo "$BATTERY_90  $BAT%"
        else
            echo "$BATTERY_80 $BAT%"
            echo "$BATTERY_80 $BAT%"
        fi

        echo $PASTEL_GREEN
    elif [ $BAT -ge 50 ]; then # Check gt 70, 60 and then else for >50
        if [ $BAT -gt 70 ]; then
            echo "$BATTERY_80 $BAT%"
            echo "$BATTERY_80 $BAT%"
        elif [ $BAT -gt 60 ]; then
            echo "$BATTERY_70 $BAT%"
            echo "$BATTERY_70  $BAT%"
        else # 50 <= $BAT <= 60
            echo "$BATTERY_60 $BAT%"
            echo "$BATTERY_60 $BAT%"
        fi

        echo $PASTEL_LIGHT_GREEN
    elif [ $BAT -ge 25 ]; then # Check gt 40, 30, and then else for >25
        if [ $BAT -gt 40 ]; then
            echo "$BATTERY_50 $BAT%"
            echo "$BATTERY_50 $BAT%"
        elif [ $BAT -gt 30 ]; then
            echo "$BATTERY_40 $BAT%"
            echo "$BATTERY_40 $BAT%"
        else
            echo "$BATTERY_30 $BAT%"
            echo "$BATTERY_30 $BAT%"
        fi

        echo $PASTEL_YELLOW
    elif [ $BAT -ge 10 ]; then # Check gt 20, then else for >10
        if [ $BAT -gt 20 ]; then
            echo "$BATTERY_30 $BAT%"
            echo "$BATTERY_30 $BAT%"
        else
            echo "$BATTERY_20 $BAT%"
            echo "$BATTERY_20 $BAT%"
        fi
        echo $PASTEL_RED
    else
        echo "$BATTERY_10 $BAT%"
        echo "$BATTERY_10 $BAT%"
        exit 33
    fi
fi

exit 0
