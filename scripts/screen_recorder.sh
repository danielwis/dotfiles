#!/bin/sh

rec=""
pause=""
resume=""
stop=""
opts="$rec\n$pause\n$resume\n$stop"
chosen_option=$(printf "$opts" | rofi -dmenu -p "Screen recording" -theme screenrec-4cols.rasi)
filename="$HOME/recordings/$(date +'%Y-%m-%d-%H:%M:%S').mkv"

get_opts(){
    printf "$opts" | tr '\n' '\t' | cut -f $1
}

# The -vf setpts... option here is some ffmpeg black magic that fixes the "freeze" that otherwise
# happens while paused. No idea how but it's got something to do with timestamps.
# -f x11grab makes the screen into an input device, :0.0 is the screen and the + coordinates are for
# screens (in this case) 1920 pixels to the left of the absolute left (i.e. the second screen).
case "$chosen_option" in
    # TODO: Enable HW acceleration in ffmpeg for this (and bump to 60fps?)
    $(get_opts 1)) notify-send "Recording screen 1" "30fps / 3840x2160" -t 2000 && ffmpeg -framerate 30 -f x11grab -s 3840x2160 -i :0.0 -vf setpts=N/FR/TB -preset ultrafast $filename
    ;;
$(get_opts 2)) pkill -STOP ffmpeg
    ;;
$(get_opts 3)) pkill -CONT ffmpeg
    ;;
$(get_opts 4)) pkill ffmpeg && notify-send "Recording saved!" "Saved at $filename"
    ;;
    *) exit 1
    ;;
esac
