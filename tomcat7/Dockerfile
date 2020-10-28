FROM tomcat:7

ARG MAVEN_VERSION=3.3.9
ARG OUTPUT_DIR="src/main/java"
ARG TOMCAT_LIB_DIR="/usr/local/tomcat/lib/"

RUN apt-get update && apt-get install -y git make  cron



# Install Maven
RUN wget http://ftp.unicamp.br/pub/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -q -O /tmp/apache-maven.tar.gz && \
    tar -xvzf /tmp/apache-maven.tar.gz -C /opt/ && \
    ln -s /opt/apache-maven-$MAVEN_VERSION /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/local/bin && \
    rm -f /tmp/apache-maven-$MAVEN_VERSION.tar.gz

ENV MAVEN_HOME /opt/maven

# Override configs and Place Built In Jars Needed by Ayannah's legacy Apps
COPY conf/tomcat-users.xml conf/
COPY lib/* $TOMCAT_LIB_DIR



EXPOSE 8080

CMD ["catalina.sh", "run"]

