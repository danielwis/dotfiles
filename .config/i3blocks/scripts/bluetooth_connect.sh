# echo "power on" | bluetoothctl > /dev/null

# echo "Scanning..."
# echo "scan on" | bluetoothctl > /dev/null

# echo "--- DEVICES ---"
# echo "devices" | bluetoothctl

# echo "--- PAIRED DEVICES ---"
# echo "paired-devices" | bluetoothctl

# echo $'\n'"To pair a device (must be done before connecting), type \"bluetoothctl -- connect \""
# echo "followed by the relevant MAC address"
# echo "To connect, type \"bluetoothctl -- connect \" followed by the relevant MAC address"

echo "power on\nscan on" | bluetoothctl > /dev/null
DEVICE=$(echo "devices" | bluetoothctl | grep "^Device" | sed 's/Device //g' | awk '{for (i=2; i<NF; i++) printf $i " "; print $NF " (" $1 ")"}' | rofi -dmenu -window-title "Bluetooth" | awk '{print $1}')

# Exit if no device specified TODO Fix, this is probably wrong
[ -z $DEVICE ] && exit

# Try to connect, on success, exit. On failure, try to pair first
# Why not echo and pipe into it as that worked above?
bluetoothctl -- connect $DEVICE
[ "$?" == "0" ] && exit
bluetoothctl -- pair $DEVICE &&  bluetoothctl -- connect $DEVICE

