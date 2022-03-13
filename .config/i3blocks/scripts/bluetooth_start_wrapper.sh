#!/bin/sh

. $(dirname $0)/vars.sh

[ "$button" = "1" ] && bluetoothctl -- power on > /dev/null && $(dirname $0)/bluetooth_connect.sh

echo " BT"
echo ""
echo $PASTEL_BLUE
