#!/bin/bash
set -e

run_sendah() {
    chown -R noreply:noreply /var/www /var/lib/php/

    exec /usr/bin/supervisord -c /etc/supervisord.conf
}

case "$1" in
    sendah)
        shift 1
        run_sendah "$@"
        ;;
    *)
        exec "$@"
esac
