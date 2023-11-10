#!/usr/bin/env bash

set -me

BLOCK=$(mktemp)
echo false > $BLOCK

while true; do
    gdbus monitor -y -d org.freedesktop.login1 2>/dev/null |
    while read -r sign; do
        case "$sign" in
            *PrepareForSleep*false*)
                echo "get wake up signal"
                ;&
            *LockedHint*false*)
                if [ $(cat $BLOCK) == false ]; then
                    echo "get unlock signal"
                    echo true > $BLOCK
                    (sleep 30; echo false > $BLOCK) &
                    echo "Restart clash.service"
                    systemctl --user --no-block restart clash.service
                else
                    echo "block too often trigger restart"
                fi
                ;;
            *PrepareForSleep*true*)
                echo "get sleep signal"
                ;;
            *LockedHint*true*)
                echo "get lock signal"
                ;;
        esac
    done
done

