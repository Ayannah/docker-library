FROM java:7
MAINTAINER John Paul Alcala, jpalcala@ayannah.com

ENV ARCHIVA_VERSION 2.2.0

RUN mkdir -p /opt/apache-archiva && \
    curl -SL http://apache.claz.org/archiva/$ARCHIVA_VERSION/binaries/apache-archiva-$ARCHIVA_VERSION-bin.tar.gz | tar xzf - -C /opt/apache-archiva --strip-components=1 && \
    useradd -rM archiva && \
    chown -R archiva:archiva /opt/apache-archiva/

VOLUME ["/opt/apache-archiva/repositories", "/opt/apache-archiva/logs", "/opt/apache-archiva/data"]

EXPOSE 8080

USER archiva
CMD ["/opt/apache-archiva/bin/archiva", "console"]
