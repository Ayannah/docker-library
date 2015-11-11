#!/bin/bash

run_gammu() {
    mkdir -p /var/spool/sms/{inbox,outbox,sent,error}

    gammu-smsd --config /etc/gammu-smsdrc "$@"
}

case "$1" in
    gammu-smsd)
        shift 1
        run_gammu "$@"
        ;;
    *)
        exec "$@"
esac
