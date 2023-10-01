#!/bin/sh

cwd=$(dirname "$0")
. "$cwd/vars.sh"

notifs=$(curl -L --silent \
	-H "Accept: application/vnd.github+json" \
	-H "Authorization: Bearer $(cat ~/Documents/personal/gh.token)" \
	-H "X-GitHub-Api-Version: 2022-11-28" \
	"https://api.github.com/notifications?all=false" | jq 'length')

echo "$NOTIFICATION_ICON $notifs"
echo "$NOTIFICATION_ICON $notifs"

if [ "$button" = "1" ]; then
	if [ "$notifs" = "0" ]; then
		notify-send "No new notifications"
	else
		xdg-open https://github.com/notifications
	fi
elif [ "$button" = "2" ]; then
	# Just open regardless of notifs using middle click
	xdg-open https://github.com/notifications
fi

[ "$notifs" = "0" ] && echo "$PASTEL_GREEN" && exit
[ "$notifs" -lt "5" ] && echo "$PASTEL_YELLOW" && exit
echo "$PASTEL_RED" && exit
