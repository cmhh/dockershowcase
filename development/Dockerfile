FROM ubuntu:20.04

ARG NODE_VERSION=14.17.2
ARG SCALA_VERSION=2.13.6

ENV DEBIAN_FRONTEND=noninteractive

RUN  apt-get update && apt-get -y dist-upgrade && \
  apt-get install -y --no-install-recommends \
    openssh-server openjdk-11-jdk locales apt-transport-https gnupg2 git vim \
    wget curl xz-utils ca-certificates build-essential gfortran && \
  sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  dpkg-reconfigure --frontend=noninteractive locales && \
  update-locale LANG=en_US.UTF-8 && \
  echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list && \
  curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add && \
  apt-get update && apt-get install -y sbt && \
  curl https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb --output packages-microsoft-prod.deb && \
  dpkg -i packages-microsoft-prod.deb && \
  apt-get update && apt-get install -y dotnet-sdk-5.0 && \
  rm packages-microsoft-prod.deb && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /usr/local/node && \
  curl -s https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz | tar xJvf - --strip-components=1 -C /usr/local/node && \
  touch /etc/bash.bashrc && \
  echo "export PATH=\$PATH:/usr/local/node/bin" >> /etc/bash.bashrc

RUN mkdir -p /usr/local/scala && \
  curl -s https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz | tar xzvf - --strip-components=1 -C /usr/local/scala && \
  echo "export PATH=\$PATH:/usr/local/scala/bin" >> /etc/bash.bashrc 

EXPOSE 22

CMD mkdir -p /root/.ssh && \
  echo "$PUB_KEY" >> /root/.ssh/authorized_keys && \
  echo "$PUB_KEY" >> /root/.ssh/id_rsa.pub && \
  echo "$PRIVATE_KEY" >> /root/.ssh/id_rsa && \
  chmod 700 /root/.ssh && chmod 600 /root/.ssh/* && \
  service ssh start && \
  tail -f /dev/null