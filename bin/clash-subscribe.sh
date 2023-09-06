#!/usr/bin/env bash

# 订阅链接地址
SUBSCRIBE="https://www.example.com/api/v1/client/subscribe?token=example&flag=clash"

CLASH_CONFIG="$HOME/.config/clash/config.yaml"

CLASH_TEMP=$(mktemp)

if [ -z "${SUBSCRIBE}" ]; then
    echo "Subscription address cannot be empty"
    exit 1
fi


wget -nv --no-proxy -O ${CLASH_TEMP} ${SUBSCRIBE}

while getopts "wes" option; do
   case $option in
      s) # display Help
         sed -i 's/log-level: info/log-level: silent/' ${CLASH_TEMP}
         ;;
      w) # display Help
         sed -i 's/log-level: info/log-level: warning/' ${CLASH_TEMP}
         ;;
      e) # display Help
         sed -i 's/log-level: info/log-level: error/' ${CLASH_TEMP}
         ;;
   esac
done


if ! cmp -s ${CLASH_TEMP} ${CLASH_CONFIG} ; then
    if [ -s ${CLASH_TEMP} ] ; then
        echo "Update the config and restart clash service."
        cat ${CLASH_TEMP} > ${CLASH_CONFIG}
        systemctl --user restart clash
    fi
fi
