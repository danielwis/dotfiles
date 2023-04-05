# A script to change the brightness through terminal commands. Used for binding
# brightness keys properly in i3.


CURR_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/brightness)
# Increase/decrease STEP_PERCENT percent per keypress
STEP_PERCENT=5
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)

let STEP_AMT=MAX_BRIGHTNESS\*$STEP_PERCENT/100

# Debug
# echo $STEP_AMT

NEW_BRIGHTNESS=$CURR_BRIGHTNESS; # Failsafe - if smth crashes, do nothing

[ "$1" == "+" ] && NEW_BRIGHTNESS=$((CURR_BRIGHTNESS+$STEP_AMT))
[ "$1" == "-" ] && NEW_BRIGHTNESS=$((CURR_BRIGHTNESS-$STEP_AMT))

# Checks
[ "$NEW_BRIGHTNESS" -lt 0 ] && NEW_BRIGHTNESS=0
[ "$NEW_BRIGHTNESS" -gt "$MAX_BRIGHTNESS" ] && NEW_BRIGHTNESS=$MAX_BRIGHTNESS

echo $NEW_BRIGHTNESS > /sys/class/backlight/intel_backlight/brightness

exit 0
