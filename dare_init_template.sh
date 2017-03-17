#!/bin/sh
#
# dare-init template
#
# dare-init follows the LSB init pattern but adds two options to
# support the dynamic nature of deploying into clouds
#
# firstboot
# boot
# update
#
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

RETVAL=0
PROG=$(basename $0)

firstboot() {
    echo -n "Firstboot"
    RETVAL=0
    return $RETVAL
}

update() {
    echo -n "Updating Package"
    RETVAL=0
    return $RETVAL
}

start() {
    echo -n "Start not implemented"
    RETVAL=3
    return $RETVAL
}

stop() {
    echo -n "Stop not implemented"
    RETVAL=3
    return $RETVAL
}

restart() {
    echo -n "Restarting"
    if stop
    then
        start
        return $?
    else
        return $?
    fi
}

reload() {
    echo -n "Reload not implemented"
    RETVAL=3
    return $RETVAL
}

status() {
    echo -n $"Checking for service $PROG:"
    RETVAL=3
    return $RETVAL
}

case "$1" in
    firstboot)
        firstboot
        RETVAL=$?
	;;
    boot)
        boot
        RETVAL=$?
	;;
    update)
        update
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
	restart|try-restart|condrestart)
        restart
        RETVAL=$?
	;;
     reload|force-reload)
        reload
        RETVAL=$?
	;;
    status)
        status
        RETVAL=$?
	;;
    *)
        echo "Usage: $0 {firstboot|update|start|start|stop|status|try-restart|condrestart|restart|force-reload|reload}"
        RETVAL=3
	;;
esac

exit $RETVAL