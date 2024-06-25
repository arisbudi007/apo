#!/bin/bash

[ -t 1 ] && . colors

source h-manifest.conf
source $CUSTOM_CONFIG_FILENAME
HOSTNAME=$(hostname)

[[ -z $CUSTOM_LOG_BASENAME ]] && echo -e "${RED}No CUSTOM_LOG_BASENAME is set${NOCOLOR}" && exit 1
[[ -z $CUSTOM_CONFIG_FILENAME ]] && echo -e "${RED}No CUSTOM_CONFIG_FILENAME is set${NOCOLOR}" && exit 1
[[ ! -f $CUSTOM_CONFIG_FILENAME ]] && echo -e "${RED}Custom config ${YELLOW}$CUSTOM_CONFIG_FILENAME${RED} is not found${NOCOLOR}" && exit 1
CUSTOM_LOG_BASEDIR=$(dirname "${CUSTOM_LOG_BASENAME}")
[[ ! -d $CUSTOM_LOG_BASEDIR ]] && mkdir -p $CUSTOM_LOG_BASEDIR

len=$(echo $ADDRESS | awk '{print length}')
if ps aux | grep 'apoolminer' | grep 'account' | grep -v 'grep'; then
    echo -e "${RED}Apoolminer already running${NOCOLOR}"
    exit 1
else
    echo "Running $NVTOOL" | tee -a ${CUSTOM_LOG_BASENAME}.log
    $NVTOOL 2>&1 | tee -a ${CUSTOM_LOG_BASENAME}.log
    echo "Finished running $NVTOOL" | tee -a ${CUSTOM_LOG_BASENAME}.log
    ./apoolminer --account $ADDRESS --pool $PROXY --rest --port ${MINER_REST_PORT} $EXTRA 2>&1 | tee --append ${CUSTOM_LOG_BASENAME}.log
fi 
