FROM ubuntu:xenial
MAINTAINER jackkdev

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get upgrade -q -y \
        && apt-get dist-upgrade -q -y \
        && apt-get install -q -y wget curl \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* \
        && cd /tmp \
        && wget https://github.com/LunariumCoin/lunarium/releases/download/v1.1.1/lunarium-1.1.1-x86_64-linux-gnu.tar.gz \
        && tar -xvzf lunarium-1.1.1-x86_64-linux-gnu.tar.gz \
        && cd lunarium-1.1.1/bin \
        && mv lunariumd lunarium-cli /usr/local/bin \
        && cd /tmp \
        && rm -Rf lunarium*

CMD ["lunariumd"]