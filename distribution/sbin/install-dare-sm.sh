#!/usr/bin/env bash

if [[ "${DARE_SM_URL}" == "" ]]
then
    echo "ERROR: must set global variable DARE_SM_URL" 1>&2
    exit 1
fi

if ! command -v  aws >/dev/null
then
    if ! pip install awscli
    then
        echo "ERROR: Failed to locate or install awscli"
        exit 1
    fi
fi

DARE_DIR=${DARE_DIR:-/opt/daring}
DARE_ETC=${DARE_ETC:-/etc/daring}

DEFAULTS=/etc/default/dare-sm
echo "
DARE_DIR=${DARE_DIR}
DARE_ETC=${DARE_ETC}
DARE_SUBSCRIBER_DIR=${DARE_SUBSCRIBER_DIR:-${DARE_DIR}/subscribers}
DARE_SUBSCRIPTION_DIR=${DARE_SUBSCRIPTION_DIR:-${DARE_ETC}/subscriptions}
RC_NOT_IMPLEMENTED=3
DARE_LOG_FILE=${DARE_LOG_FILE:-/var/log/daring.log}
" > $DEFAULTS

. $DEFAULTS

function error {
	echo $*
	exit 2
}

if [[ ${DARE_SM_URL} == s3* ]]
then
    aws s3 sync ${DARE_SM_URL} ${DARE_DIR}
else
    echo "ERROR: ${DARE_SM_URL} currently not supported" 2>/dev/null
    exit 1
fi

chmod +x $DARE_DIR/*bin/*
SM=${DARE_DIR}/sbin/dare-sm

for URL in $(echo $DARE_SUBSCRIBER_URL | perl -pe 's/:/ /g')
do
    ${SM} add $URL
done

if [[ "$1" == "download" ]]
then
    exit 0
fi

${SM} subscribe ${DARE_SUBSCRIBER_DIR}

if [[ "$1" == "subscribe" ]]
then
    exit 0
fi

${SM} install all
${SM} install-start all
