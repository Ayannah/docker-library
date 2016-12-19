FROM centos:centos7

ARG MAVEN_VERSION=3.3.9


#Install WGET
RUN yum -y install epel-release && \
    yum -y upgrade && \
    yum -y install gcc gcc-c++ ncurses-devel install tar cmake make wget\
        bluez-libs-devel libcurl-devel \
        gettext-devel libdbi-devel dialog wget \
        python-devel python-pip thrift thrift-devel openssh-clients && \
    yum clean all -y && \
    rm -rf /var/cache/yum/* /tmp/*


COPY core-api-key /root/.ssh/id_rsa
COPY core-api-key.pub /root/.ssh/id_rsa.pub
COPY requirements.txt /opt/


RUN chmod 755 $HOME/.ssh && \
    chmod 600 $HOME/.ssh/id_rsa && \
    ssh-keyscan -H github.com >> $HOME/.ssh/known_hosts && \
    PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig/ pip install -r /opt/requirements.txt

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
RUN cd /tmp;wget http://mirror.rise.ph/apache/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz


# untar and move to proper location
RUN cd /tmp;tar xvf apache-tomcat-7.0.73.tar.gz
RUN cd /tmp;mv apache-tomcat-7.0.73 /opt/tomcat7
RUN chmod -R 755 /opt/tomcat7

# Override configs
COPY conf/tomcat-users.xml /opt/tomcat7/conf


ENV JAVA_HOME /opt/jdk1.7.0_79

WORKDIR /opt
RUN ln -s jdk1.7.0_79 java && ln -s apache-maven-$MAVEN_VERSION maven

RUN  mvn -v
RUN cd /src/ayannahcore-api && \
    /usr/bin/mvn package &&  \
    cd target/ && \
    cp -rv *.jar  /opt/tomcat7/lib/
RUN ls /opt/tomcat7/lib/ -1l 

# Copy libraries
COPY lib/*.jar /opt/tomcat7/lib/

EXPOSE 8080

CMD /opt/tomcat7/bin/catalina.sh run
