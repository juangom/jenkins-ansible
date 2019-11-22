FROM jenkins/jenkins:lts

USER root

RUN apt update
RUN apt -y install build-essential checkinstall
RUN apt -y install libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

# Install python
WORKDIR /usr/src
RUN wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
RUN tar xzf Python-3.7.3.tgz

WORKDIR /usr/src/Python-3.7.3
RUN ./configure --enable-optimizations
RUN make altinstall
RUN rm /usr/src/Python-3.7.3.tgz

RUN mkdir /home/app
WORKDIR /home/app

RUN python3.7 -m pip install pip
RUN python3.7 -m pip install --upgrade pip
RUN python3.7 -m pip install ansible

USER jenkins
