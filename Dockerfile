#FROM python:3.6.4-stretch
FROM python:2.7-wheezy

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -q -y update \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install apt-utils \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install nano net-tools \
 && apt-get -q -y autoremove \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/*
 
#RUN pip -i
#RUN virtualenv env
#pip3 install virtualenv

RUN mkdir -p /src
COPY . /src
#COPY staticDHCPd /src
#COPY install.sh /src

RUN cd /src && ./install.sh

# Configuration
COPY staticDHCPd/conf/conf.py.docker /etc/staticDHCPd/conf.py

ENTRYPOINT ["staticDHCPd"]
