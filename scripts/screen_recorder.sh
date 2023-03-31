#!/bin/sh

opts='1:  ¹ Record left screen\n2:  ² Record right screen\n3:  Pause\n4:  Resume\n5:  Stop'
chosen_option=$(printf "$opts" | rofi -dmenu -p "")
filename="$HOME/recordings/$(date +'%Y-%m-%d-%H:%M:%S').mkv"

get_opts(){
    printf "$opts" | tr '\n' '\t' | cut -f $1
}

# The -vf setpts... option here is some ffmpeg black magic that fixes the "freeze" that otherwise
# happens while paused. No idea how but it's got something to do with timestamps.
# -f x11grab makes the screen into an input device, :0.0 is the screen and the + coordinates are for
# screens (in this case) 1920 pixels to the left of the absolute left (i.e. the second screen).
case "$chosen_option" in
    $(get_opts 1)) notify-send "Recording screen 1" "60fps / 1920x1080" -t 2000 && ffmpeg -framerate 60 -f x11grab -s 1920x1080 -i :0.0 -vf setpts=N/FR/TB $filename
    ;;
    $(get_opts 2)) notify-send "Recording screen 2" "60fps / 1920x1080" -t 2000 && ffmpeg -framerate 60 -f x11grab -s 1920x1080 -i :0.0+1920,0 -vf setpts=N/FR/TB $filename
    ;;
$(get_opts 3)) pkill -STOP ffmpeg
    ;;
$(get_opts 4)) pkill -CONT ffmpeg
    ;;
$(get_opts 5)) pkill ffmpeg && notify-send "Recording saved!" "Saved at $filename"
    ;;
    *) exit 1
    ;;
esac
