FROM centos:centos7
MAINTAINER John Paul Alcala, jpalcala@ayannah.com

RUN yum -y install epel-release && \
    yum -y upgrade && \
    yum -y install gcc gcc-c++ ncurses-devel install tar cmake make \
        postgresql-devel bluez-libs-devel libusb-devel libcurl-devel \
        gettext-devel mariadb-devel libdbi-devel dialog \
        python-devel sqlite-devel python-pip && \
    yum clean all -y && \
    rm -rf /var/cache/yum/* /tmp/*

RUN curl -SL http://downloads.sourceforge.net/project/gammu/gammu/1.35.0/gammu-1.35.0.tar.gz | tar xzvf - -C /tmp && \
    cd /tmp/gammu-1.35.0 && \
    ./configure && \
    make && \
    make install && \
    ln -s /usr/local/lib64/libGammu.so.7 /usr/lib64/libGammu.so.7 && \
    ln -s /usr/local/lib64/libgsmsd.so.7 /usr/lib64/libgsmsd.so.7 && \
    mkdir -p /var/spool/sms/{inbox,outbox,sent,error} && \
    cd / && \
    rm -rf /tmp/gammu-1.35.0 && \
    PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig/ pip install python-gammu

COPY gammu-smsdrc /etc/gammu-smsdrc
COPY sms.sh /

CMD ["gammu-smsd", "--config", "/etc/gammu-smsdrc"]
