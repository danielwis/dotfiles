#!/bin/bash

. "$(dirname "$0")"/vars.sh

max_abbrev_name_len=8
# The word to display if output is abbreviated and the name is too long
abbrev_word="Connected"

if [ "$button" = "1" ]; then
  # Display stats?
  : #nop
fi

device_name=$(bluetoothctl info | sed -n 's/.*Name: \(.*\)/\1/p')
if [ -n "$device_name" ]; then
  name_len=$(wc -c <(echo "$device_name") | cut -d' ' -f1)
  if [ $name_len -gt $max_abbrev_name_len ]; then
    abbrev_name="$(head -c $((max_abbrev_name_len - 3)) <(echo $device_name) | sed 's/\s$//')"
    abbrev_name="${abbrev_name}..."
  else
    abbrev_name=$device_name
  fi

  # Regular text
  echo "$BLUETOOTH_ICON $device_name"

  # Abbreviated name
  name_len=$(wc -c <(echo "$device_name") | cut -d' ' -f1)
  abbrev_word_len=$(wc -c <(echo "$abbrev_word") | cut -d' ' -f1)
  if [ $name_len -gt $abbrev_word_len ]; then
    echo "$BLUETOOTH_ICON $abbrev_word"
  else
    echo "$BLUETOOTH_ICON $abbrev_name"
  fi

  # Colour
  echo "#7591ff"
fi
