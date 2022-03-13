#!/bin/sh

# TODO: Cleanup, looks like shit

. $(dirname $0)/vars.sh

echo "$POWER_ICON"
echo "$POWER_ICON"
echo "#dddddd"

image=$(maim /tmp/lock.png)
i3lock_cmd=$(cat ./lockscreen)

if [ "$button" = "1" ]; then
    # Color variable ripped off i3lock-fancy
    # (https://github.com/meskarune/i3lock-fancy/blob/master/i3lock-fancy)
    color=$(convert "$image" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
        -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');
            value=60 # Also stolen

            if [ $color -lt $value ]; then # dark ackground image and white text
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
                                else
                                    i3lock \
                                        --blur=5 \
                                        -k \
                                        --indicator \
                                        --ring-width 5 \
                                        --ring-color=00000088 \
                                        --ringver-color=00000088 \
                                        --ringwrong-color=ff222255 \
                                        --inside-color=00000000 \
                                        --insidever-color=33333300 \
                                        --insidewrong-color=00000000 \
                                        --keyhl-color=33333390 \
                                        --time-color=333333dd \
                                        --date-color=333333dd \
                                        --date-str="%a, %d %b %Y" \
                                        --line-uses-inside \
                                        --verif-text="..." \
                                        --verif-color=333333dd \
                                        --wrong-text="" \
                                        --greeter-text="Type password to unlock" \
                                        --greeter-pos="ix:550" \
                                        --greeter-color=333333dd \
                                        -e
            fi

            systemctl suspend # && rofi -show window
fi
