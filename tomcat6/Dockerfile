FROM centos:centos6

#Install WGET
RUN yum install -y wget

#Install tar
RUN yum install -y tar

# Download JDK
RUN cd /opt;wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz; pwd

RUN cd /opt;tar xvf jdk-7u79-linux-x64.tar.gz
RUN alternatives --install /usr/bin/java java /opt/jdk1.7.0_79/bin/java 2

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

EXPOSE 8080

CMD /opt/tomcat6/bin/catalina.sh run