#!/bin/sh

cwd=$(dirname "$0")
. "$cwd/vars.sh"

url="https://github.com/notifications"

notifs=$(curl -L --silent \
	-H "Accept: application/vnd.github+json" \
	-H "Authorization: Bearer $(cat ~/Documents/personal/gh.token)" \
	-H "X-GitHub-Api-Version: 2022-11-28" \
	"https://api.github.com/notifications?all=false" | jq 'length')

echo "$NOTIFICATION_ICON $notifs"
echo "$NOTIFICATION_ICON $notifs"

if [ "$button" = "1" ]; then
	notify-send "$notifs new notification(s)" "<a href=\"$url\">Click to open in browser</a>"
elif [ "$button" = "2" ]; then
	# Just open
	xdg-open $url
fi

[ "$notifs" = "0" ] && echo "$PASTEL_GREEN" && exit
[ "$notifs" -lt "5" ] && echo "$PASTEL_YELLOW" && exit
echo "$PASTEL_RED" && exit
