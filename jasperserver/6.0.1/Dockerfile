FROM tomcat:7
MAINTAINER John Paul Alcala jp@jpalcala.com

RUN curl -SL http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperReports%20Server%20Community%20Edition%206.0.1/jasperreports-server-cp-6.0.1-bin.zip -o /tmp/jasperserver.zip && \
    unzip /tmp/jasperserver.zip -d /usr/src/ && \
    mv /usr/src/jasperreports-server-cp-6.0.1-bin /usr/src/jasperreports-server && \
    rm -rf /tmp/*

ENV CATALINA_OPTS "-Xmx1G -XX:MaxPermSize=256m -XX:+UseBiasedLocking -XX:BiasedLockingStartupDelay=0 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC -XX:+CMSIncrementalMode -XX:+CMSIncrementalPacing -XX:+CMSParallelRemarkEnabled -XX:+UseCompressedOops -XX:+UseCMSInitiatingOccupancyOnly"

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]
