#!/bin/bash
set -e

run_archiva() {
    chown -R archiva:archiva /opt/apache-archiva
    exec gosu archiva /opt/apache-archiva/bin/archiva console
}

case "$1" in
    archiva)
        shift 1
        run_archiva
        ;;
    *)
        exec "$@"
esac
