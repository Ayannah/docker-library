FROM java:7
MAINTAINER John Paul Alcala, jpalcala@ayannah.com

# Taken from Postgres Official Dockerfile.
# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

ENV ACTIVEMQ_HOME="/usr/local/activemq" ACTIVEMQ_BASE="/var/lib/activemq" ACTIVEMQ_OPTS_MEMORY="-Xms256M -Xmx256M"

RUN \
    groupadd -g 1000 activemq && \
    useradd -g activemq -u 1000 -r -M activemq && \
    mkdir -p $ACTIVEMQ_HOME && \
    curl -SL http://www.apache.org/dist/activemq/KEYS -o /tmp/KEYS && \
    curl -SL http://archive.apache.org/dist/activemq/apache-activemq/5.4.3/apache-activemq-5.4.3-bin.tar.gz -o /tmp/apache-activemq.tar.gz && \
    curl -SL http://archive.apache.org/dist/activemq/apache-activemq/5.4.3/apache-activemq-5.4.3-bin.tar.gz.asc -o /tmp/apache-activemq.tar.gz.asc && \
    gpg --import /tmp/KEYS && \
    gpg --verify /tmp/apache-activemq.tar.gz.asc && \
    tar xzf /tmp/apache-activemq.tar.gz -C $ACTIVEMQ_HOME --strip-components=1 && \
    ln -s /usr/local/activemq/bin/activemq /usr/local/bin/activemq && \
    rm -rf /tmp/*

COPY activemq-entrypoint.sh /

EXPOSE 61616 8161

VOLUME ["$ACTIVEMQ_BASE"]

ENTRYPOINT ["/activemq-entrypoint.sh"]

CMD ["activemq"]
