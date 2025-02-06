#!/usr/bin/env bash

thresholds=(20 10 5 2)
flags=("/tmp/battery_notify_20" "/tmp/battery_notify_10" "/tmp/battery_notify_5" "/tmp/battery_notify_2")
messages=(
    "Battery is low: 20%. Please plug in your charger."
    "Battery is critically low: 10%. Connect to a power source immediately."
    "Battery is very critically low: 5%. The system might shut down soon."
    "Battery is nearly empty: 2%. Saving your work is highly recommended."
)

get_battery_level() {
    cat /sys/class/power_supply/BAT*/capacity
}

while true; do
    battery_level="$(get_battery_level)"

    if [ "$battery_level" -gt 20 ]; then
        for flag in "${flags[@]}"; do
            if [ -f "$flag" ]; then
                rm "$flag"
            fi
        done
    else
        for i in "${!thresholds[@]}"; do
            threshold=${thresholds[$i]}
            flag=${flags[$i]}
            message=${messages[$i]}
            if [ "$battery_level" -le "$threshold" ] && [ ! -f "$flag" ]; then
                notify-send "$message"
                touch "$flag"
            fi
        done
    fi

    sleep 60
done
