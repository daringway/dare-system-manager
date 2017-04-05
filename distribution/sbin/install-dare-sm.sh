#!/usr/bin/env bash

if [[ ${DARESM_URL} == "" ]]
then
    echo "ERROR: must set global variable DARESM_URL" 2>/dev/null
    exit 1
fi

export DARESM_DIR=/opt/daring

function error {
	echo $*
	exit 2
}

if [[ ${DARESM_URL} == s3* ]]
then
    aws s3 sync ${DARESM_URL} ${DARESM_DIR}
else
    echo "ERROR: ${DARESM_URL} currently not supported" 2>/dev/null
    exit 1
fi

chmod +x $DARESM_DIR/*bin/*

if [[ "$1" == "download" ]]
then
    exit 0
fi

SM=${DARESM_DIR}/sbin/dare-sm

${SM} subscribe ${DARESM_DIR}/subscribers

if [[ "$1" == "subscribe" ]]
then
    exit 0
fi

${SM} install all
${SM} install-start all
