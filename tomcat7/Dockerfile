FROM tomcat:8

ARG MAVEN_VERSION=3.3.9
ARG OUTPUT_DIR="src/main/java"
ARG TOMCAT_LIB_DIR="/usr/local/tomcat/lib/"

RUN apt-get update && apt-get install -y git openjdk-8-jdk make thrift-compiler cron

COPY core-api-key /root/.ssh/id_rsa
COPY core-api-key.pub /root/.ssh/id_rsa.pub

# Clone core-api
RUN chmod 755 /root/.ssh && \
    chmod 600 /root/.ssh/id_rsa && \
    ssh-keyscan -H github.com >> /root/.ssh/known_hosts && \
    git clone -b develop git@github.com:Ayannah/core-api.git

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


# Install Core API
RUN  cd core-api/ && \
     mkdir -p $OUTPUT_DIR && \
     GENDIR=$OUTPUT_DIR TARGET=java make && \
     mvn package && \
     cp -rv target/core-api-1.0.jar $TOMCAT_LIB_DIR;

EXPOSE 8080

CMD ["catalina.sh", "run"]

