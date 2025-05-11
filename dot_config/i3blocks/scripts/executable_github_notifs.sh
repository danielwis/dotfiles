#!/bin/sh

cwd=$(dirname "$0")
. "$cwd/vars.sh"

url="https://github.com/notifications"

notifs=$(curl -L --silent \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $(cat ~/Documents/personal/gh.token)" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/notifications?all=false" | jq 'length')

if [ -n "$notifs" ]; then
  echo "$NOTIFICATION_ICON $notifs"
  echo "$NOTIFICATION_ICON $notifs"

  # Colour
  if [ "$notifs" = "0" ]; then
    echo "$PASTEL_GREEN"
  elif [ "$notifs" -lt "5" ]; then
    echo "$PASTEL_YELLOW"
  else
    echo "$PASTEL_RED"
  fi
else
  echo "$NOTIFICATION_ICON (?)"
  echo "$NOTIFICATION_ICON (?)"
  echo "#ffac1c" # orange
  # echo "#ffbf00" # orange
fi

if [ "$button" = "1" ]; then
  if [ -n "$notifs" ]; then
    notify-send "$notifs new notification(s)" "<a href=\"$url\">Click to open in browser</a>"
  else
    notify-send -i "$HOME/.config/dunst/exclamation-solid.png" "Unable to obtain notification info"
  fi
elif [ "$button" = "2" ]; then
  # Just open
  xdg-open $url
fi
