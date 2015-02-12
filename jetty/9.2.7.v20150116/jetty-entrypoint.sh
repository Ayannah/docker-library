#!/bin/bash
set -e

run_jetty() {
    mkdir -p $JETTY_BASE

    if [ $# -eq 0 ] && [ ! -f $JETTY_BASE/start.ini ]; then
        java -jar $JETTY_HOME/start.jar --add-to-start=http,deploy,jsp,jstl,annotations,logging jetty.base=$JETTY_BASE && \
        java -jar $JETTY_HOME/start.jar --add-to-startd=http jetty.base=$JETTY_BASE
    fi

    chown -R jetty:jetty $JETTY_BASE

    pushd $JETTY_BASE > /dev/null
    exec gosu jetty /usr/bin/java $JETTY_OPTS -jar $JETTY_HOME/start.jar "$@"
}

case "$1" in
    jetty)
        shift 1
        run_jetty "$@"
        ;;
    *)
        exec "$@"
esac
