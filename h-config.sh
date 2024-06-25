#!/usr/bin/env bash

cd `dirname $0`

[[ "$CUSTOM_URL" = "" ]] && echo "Using default address" && CUSTOM_URL="qubic1.hk.apool.io:3334"
if echo "$CUSTOM_USER_CONFIG"|grep nvtool;then
    CUSTOM_NVTOOL=$(echo "$CUSTOM_USER_CONFIG" |head -1)
    CUSTOM_USER_CONFIG=$(echo "$CUSTOM_USER_CONFIG"|grep -v nvtool)
fi
conf=""
conf+="ADDRESS=\"$CUSTOM_TEMPLATE\""$'\n'
conf+="PROXY=\"$CUSTOM_URL\""$'\n'
conf+="PASS=\"$CUSTOM_PASS\""$'\n'
conf+="NVTOOL=\"$CUSTOM_NVTOOL\""$'\n'
conf+="EXTRA=\"$CUSTOM_USER_CONFIG\""$'\n'

echo "$conf" > $CUSTOM_CONFIG_FILENAME
