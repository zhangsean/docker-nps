FROM alpine

LABEL MAINTAINER "ZhangSean <zxf2342@qq.com>"

ENV NPS_VERSION=v0.26.10 \
    PATH=/nps:$PATH \
    NPS_MODE=client \
    NPS_BRIDGE_TYPE=tcp \
    NPS_BRIDGE_PORT=8024 \
    NPS_PUBLIC_VKEY=123 \
    NPS_HTTP_PROXY_PORT=80 \
    NPS_HTTPS_PROXY_PORT=443 \
    NPS_WEB_USERNAME=admin \
    NPS_WEB_PASSWORD=123 \
    NPS_WEB_PORT=8080 \
    NPS_HTTP_CACHE=false \
    NPC_SERVER_ADDR=127.0.0.1:8024 \
    NPC_CONN_TYPE=tcp \
    NPC_VKEY=123

ADD entrypoint.sh /nps/entrypoint.sh

WORKDIR /nps

RUN wget https://github.com/ehang-io/nps/releases/download/${NPS_VERSION}/linux_amd64_server.tar.gz \
 && tar -zxvf linux_amd64_server.tar.gz \
 && rm -rf linux_amd64_server.tar.gz \
 && wget https://github.com/ehang-io/nps/releases/download/${NPS_VERSION}/linux_amd64_client.tar.gz \
 && tar -zxvf linux_amd64_client.tar.gz \
 && rm -rf linux_amd64_client.tar.gz

EXPOSE 80 443 8024 8080

CMD ["sh", "/nps/entrypoint.sh"]
