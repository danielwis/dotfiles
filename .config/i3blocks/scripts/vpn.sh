#!/bin/bash

. $(dirname $0)/vars.sh

DEFAULT_IFC="vpn"
IFC=$(sudo wg show | sed 's/\x1B\[[0-9;]*[JKmsu]//g' | head -n 1 | sed 's/interface: //' | tr -d -c "A-Za-z0-9_-")

if [ "$button" = "1" ]; then
    if [ -z $IFC ]; then
        sudo wg-quick up $DEFAULT_IFC
        notify-send "VPN up"
    else
        sudo wg-quick down $DEFAULT_IFC
        notify-send "VPN down"
    fi
fi

# Re-load ifc in case button press did anything
IFC=$(sudo wg show | sed 's/\x1B\[[0-9;]*[JKmsu]//g' | head -n 1 | sed 's/interface: //')

if [ -z $IFC ]; then
    echo "󰦞 VPN off" && echo "󰦞 VPN" && echo $PASTEL_YELLOW;
else
    echo "󰕥 VPN on" && echo "󰕥 VPN" && echo $PASTEL_GREEN;
fi
