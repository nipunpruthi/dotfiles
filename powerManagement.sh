#!/bin/bash

get_percentage()
{
     # Note, | \ must have only new line after it, no space
     upower --show-info /org/freedesktop/UPower/devices/DisplayDevice |\
     awk '/percentage/{gsub(/\%/,""); print $2}'
}

get_state()
{
     # Note, | \ must have only new line after it, no space
     upower --show-info /org/freedesktop/UPower/devices/DisplayDevice |\
     awk '/state/{gsub(/\%/,""); print $2}'
}

main()
{
    while true
    do
        state=$(get_state)
        if [ $state == "discharging" ];
        then
            pcent=$(get_percentage)
            if [ $pcent -le 15 ]
            then
                notify-send $pcent "Battery Low, Please plug in the charger" && aplay "/home/nipun/dotfiles/beep.wav"
            fi
        fi
        sleep 300 # check every minute
    done
}
main
