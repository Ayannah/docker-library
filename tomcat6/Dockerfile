FROM centos:centos6

ARG MAVEN_VERSION=3.3.9


#Install WGET
RUN yum install -y wget

#Install tar
RUN yum install -y tar

# Download JDK
RUN cd /opt;wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz; pwd



# Install Maven
RUN cd /opt; wget http://ftp.unicamp.br/pub/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -q -O apache-maven.tar.gz && \
    tar -xzf apache-maven.tar.gz
##&& rm apache-maven.tar.gz 


RUN cd /opt;tar xvf jdk-7u79-linux-x64.tar.gz
RUN alternatives --install /usr/bin/java java /opt/jdk1.7.0_79/bin/java 2
RUN alternatives --install /usr/bin/jar jar /opt/jdk1.7.0_79/bin/jar 2 && \
    alternatives --install /usr/bin/javac javac /opt/jdk1.7.0_79/bin/javac 2 && \
    alternatives --set java /opt/jdk1.7.0_79/bin/java && \
    alternatives --set jar /opt/jdk1.7.0_79/bin/jar && \
    alternatives --set javac /opt/jdk1.7.0_79/bin/javac && \
    alternatives --install /usr/bin/mvn mvn /opt/maven/bin/mvn 1



# Download Apache Tomcat 6
RUN cd /tmp;wget http://mirror.rise.ph/apache/tomcat/tomcat-6/v6.0.47/bin/apache-tomcat-6.0.47.tar.gz
# untar and move to proper location
RUN cd /tmp;tar xvf apache-tomcat-6.0.47.tar.gz
RUN cd /tmp;mv apache-tomcat-6.0.47 /opt/tomcat6
RUN chmod -R 755 /opt/tomcat6

# Override configs
COPY conf/tomcat-users.xml /opt/tomcat6/conf

# Copy libraries
COPY lib/*.jar /opt/tomcat6/lib/

ENV JAVA_HOME /opt/jdk1.7.0_79

WORKDIR /opt
RUN ln -s jdk1.7.0_79 java && ln -s apache-maven-$MAVEN_VERSION maven

EXPOSE 8080

CMD /opt/tomcat6/bin/catalina.sh run
