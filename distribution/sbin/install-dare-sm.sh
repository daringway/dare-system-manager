#!/usr/bin/env bash

INSTALLDIR=/opt/dare

function error {
	echo $*
	exit 2
}

aws s3 sync s3://daring-packages/dare-opt/ ${INSTALLDIR}
chmod +x $INSTALLDIR/*bin/*

if [[ "$1" == "download" ]]
then
    exit 0
fi

SM=${INSTALLDIR}/sbin/dare-sm

${SM} subscribe ${INSTALLDIR}/subscribers

if [[ "$1" == "subscribe" ]]
then
    exit 0
fi

${SM} install all
${SM} install-start all
