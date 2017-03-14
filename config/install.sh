#!/usr/bin/env bash

INSTALLDIR=
S3CONFIG

function error {
	echo $*
	exit 2
}


# Install the dare-sm and subscriptions
# dare-sm subscribe --dir
# dare-sm install --dir
# dare-sm firstboot all
# dare-sm start all
