FROM tomcat:7

ARG MAVEN_VERSION=3.3.9
ARG OUTPUT_DIR="src/main/java"

RUN apt-get update && apt-get install -y git openjdk-7-jdk make

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

# Override configs
COPY conf/tomcat-users.xml conf/

# Install Core API
RUN  cd core-api/; mkdir -p src/main/java; GENDIR=$OUTPUT_DIR TARGET=java make; mvn package;

EXPOSE 8080

CMD ["catalina.sh", "run"]

