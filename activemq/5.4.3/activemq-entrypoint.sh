#!/bin/bash
set -e

run_activemq() {
    if [ $# -eq 0 ] && { ! find $ACTIVEMQ_BASE -mindepth 1 -print -quit | grep -q .; }; then
        mkdir -p $ACTIVEMQ_BASE/data && cp -rf $ACTIVEMQ_HOME/conf $ACTIVEMQ_BASE
    fi

    chown -R activemq:activemq $ACTIVEMQ_BASE

    exec gosu activemq /usr/local/bin/activemq ${@:-console}
}

case "$1" in
    activemq)
        shift 1
        run_activemq "$@"
        ;;
    *)
        exec "$@"
esac
