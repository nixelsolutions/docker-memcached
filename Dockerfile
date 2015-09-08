FROM ubuntu:14.04

MAINTAINER Manel Martinez <manel@nixelsolutions.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common supervisor
RUN add-apt-repository ppa:niedbalski/memcached-repcached
RUN echo "deb http://ppa.launchpad.net/niedbalski/memcached-repcached/ubuntu trusty main" >> /etc/apt/sources.list.d/memcached.list

RUN apt-get update && \
    apt-get -y install memcached

ENV MEMCACHED_PEERS **ChangeMe**
ENV MY_IP **ChangeMe**
ENV MEMCACHED_PORT 11211
ENV MEMCACHED_MAX_MEM 64
ENV MEMCACHED_MAX_CONN 1024

ENV DEBUG 0

EXPOSE ${MEMCACHED_PORT}

RUN mkdir -p /var/log/supervisor
RUN mkdir -p /usr/local/bin
ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh
ADD ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/local/bin/run.sh"]
