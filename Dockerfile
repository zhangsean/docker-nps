FROM alpine
MAINTAINER zhangsean <zxf2342@gmail.com>

ENV NPS_VERSION 0.25.2
ENV NPS_RELEASE_URL https://github.com/cnlh/nps/releases/download/v${NPS_VERSION}/linux_amd64_server.tar.gz

RUN set -x && \
    mkdir /nps && \
    cd /nps && \
    wget --no-check-certificate ${NPS_RELEASE_URL} && \ 
    tar xzf linux_amd64_server.tar.gz && \
    ./nps install && \
    rm -rf /nps

VOLUME /etc/nps/conf

CMD nps
