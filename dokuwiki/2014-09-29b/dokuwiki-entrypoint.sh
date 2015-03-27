#!/bin/bash
set -e

run_dokuwiki() {
    chown -R www:www /var/www /var/lib/nginx

    exec /usr/bin/supervisord -c /etc/supervisord.conf
}

case "$1" in
    dokuwiki)
        shift 1
        run_dokuwiki "$@"
        ;;
    *)
        exec "$@"
esac
