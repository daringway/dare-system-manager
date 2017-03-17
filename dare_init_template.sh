#!/bin/sh
#
# Steps:
# 1) Rename to ##-service name.  Example:  25-fluent
# 2) Move into the correct subscribers directory
# 3) At minimum implement the install function.
#    This should install any packages and configurations as needed
# 4) If the service has start/stop options then implement them as well.
# 5) If there are options then put the DEFAULTS between the tags below
# 6) Optional options to implement include boot, reload, status

install() {
    return 3
}

start() {
    return 3
}

stop() {
    return 3
}

stop() {
    return 3
}

restart() {
    if stop
    then
        start
        return $?
    else
        return $?
    fi
}

case "$1" in
    install)
        install
        RETVAL=$?
	;;
    start)
        start
        RETVAL=$?
    ;;
    stop)
        stop
        RETVAL=$?
	;;
	restart)
        restart
        RETVAL=$?
    ;;
    status)
        status
        RETVAL=$?
	;;
    *)
        echo "$0: $1 option not implemented"
        echo "Usage: $0 {install|start|stop|restart}"
        RETVAL=3
	;;
esac

exit $RETVAL

# LSB RC (Return Codes) for all commands but status:
# 0	 - success
# 1  - generic or unspecified error
# 2  - invalid or excess argument(s)
# 3  - unimplemented feature (e.g. "reload")
# 4  - user had insufficient privileges
# 5  - program is not installed
# 6  - program is not configured
# 7  - program is not running
# 8--199  - reserved (8--99 LSB, 100--149 distrib, 150--199 appl)
#
# Note that starting an already running service, stopping
# or restarting a not-running service as well as the restart
# with force-reload (in case signaling is not supported) are
# considered a success.
#
# LSB RC for status command:
# 0 - service up and running
# 1 - service dead, but /var/run/  pid  file exists
# 2 - service dead, but /var/lock/ lock file exists
# 3 - service not running (unused)
# 4 - service status unknown :-(
# 5--199 reserved (5--99 LSB, 100--149 distro, 150--199 appl.)