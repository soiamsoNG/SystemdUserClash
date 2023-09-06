#!/usr/bin/env bash

while true; do
    dbus-monitor --system "type='signal',path='/org/freedesktop/login1',interface='org.freedesktop.login1.Manager',member=PrepareForSleep" 2>/dev/null |
    while read -r sign; do
        case "$sign" in
            *"boolean false"*)
                echo "Restarting Clash Service"
                systemctl --user --no-block restart clash.service
                ;;
            *"boolean true"*)   echo "Before Sleep";;
        esac
    done
done

