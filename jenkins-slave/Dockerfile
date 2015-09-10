FROM docker.io/java:openjdk-7-jdk
MAINTAINER Jess Malvin Chin, jess@teamcodeflux.com
RUN apt-get update && apt-get install -y curl \
    openssh-server \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm && \
  rm -rf /var/lib/apt/lists/*

ENV ANDROID_SDK_VERSION r24.3.4
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

RUN mkdir -p $ANDROID_HOME && \
    curl http://dl.google.com/android/android-sdk_$ANDROID_SDK_VERSION-linux.tgz | tar xzf - -C $ANDROID_HOME --strip-components=1

RUN mkdir /var/run/sshd

RUN useradd jenkins

RUN mkdir -p /home/jenkins/.ssh
ADD id_rsa.pub /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins /home/jenkins && chmod 0700 /home/jenkins/.ssh

RUN curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

USER jenkins
WORKDIR /home/jenkins
RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv

ENV HOME /home/jenkins
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install 3.4.3
RUN pyenv global 3.4.3
RUN pyenv rehash

EXPOSE 22
CMD /usr/sbin/sshd -D

