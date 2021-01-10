FROM ubuntu:latest

ENV LUNARIUM_VERSION=1.3.0
ENV LUNARIUM_URL=https://github.com/LunariumCoin/lunarium/releases/download/v1.3.0/lunarium-1.3.0-x86_64-linux-gnu.tar.gz
ENV LUNARIUM_USER=lunarium
ENV LUNARIUM_CONF=/home/$LUNARIUM_USER/.lunarium/lunarium.conf

RUN apt-get -qq update && \
apt-get install -yq procps sudo wget ca-certificates pwgen && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
wget $LUNARIUM_URL -O /tmp/lunarium.tar.gz && \
mkdir -p /opt && \
cd /opt && \
tar xvzf /tmp/lunarium.tar.gz && \
rm /tmp/lunarium.tar.gz && \
ln -sf lunarium-$LUNARIUM_VERSION lunarium && \
ln -sf /opt/lunarium/bin/lunariumd /usr/local/bin/lunariumd && \
ln -sf /opt/lunarium/bin/lunarium-cli /usr/local/bin/lunarium-cli && \
ln -sf /opt/lunarium/bin/lunarium-tx /usr/local/bin/lunarium-tx && \
groupadd ${LUNARIUM_USER} && \
adduser --uid 1000 --system ${LUNARIUM_USER} && \
mkdir -p /home/${LUNARIUM_USER}/.lunarium/ && \
chown -R ${LUNARIUM_USER} /home/${LUNARIUM_USER} && \
echo "success: $LUNARIUM_CONF"

RUN echo "${LUNARIUM_USER}:${LUNARIUM_USER}" | chpasswd && adduser ${LUNARIUM_USER} sudo

USER lunarium
RUN echo "rpcuser=lunarium" > ${LUNARIUM_CONF} && \
        echo "rpcpassword=`pwgen 32 1`" >> ${LUNARIUM_CONF} && \
        echo "Success"

EXPOSE 44071
VOLUME ["/home/lunarium/.lunarium"]
WORKDIR /home/lunarium

ENTRYPOINT ["/usr/local/bin/lunariumd"]
