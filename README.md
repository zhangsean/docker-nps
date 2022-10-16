# zhangsean/nps

Containerized `nps` and `npc` based on alpine.

Docker image for [ehang-io/nps](https://github.com/ehang-io/nps).

[![Docker Pulls](https://img.shields.io/docker/pulls/zhangsean/nps.svg)](https://hub.docker.com/r/zhangsean/nps)
[![Docker Image Size](https://img.shields.io/docker/image-size/zhangsean/nps.svg?sort=semver)](https://hub.docker.com/r/zhangsean/nps)
[![Docker Image Version](https://img.shields.io/docker/v/zhangsean/nps.svg?sort=semver)](https://hub.docker.com/r/zhangsean/nps/tags)
[![GitHub Release](https://img.shields.io/github/v/release/zhangsean/docker-nps.svg)](https://github.com/zhangsean/docker-nps)

## Tags

- latest
- v0.26.10

## Environment variables

Name | Type | Default | Description
-|-|-|-
NPS_MODE | server / client / all | client | Container running model
NPS_BRIDGE_TYPE | tpc / udp | tcp | Bridge type for client connect to
NPS_BRIDGE_PORT | Port | 8024 | Bridge bind port for client connect to
NPS_PUBLIC_VKEY | String | 123 | Public key for client authorize, empty to disable
NPS_HTTP_PROXY_PORT | Port | 80 | Http proxy bind port
NPS_HTTPS_PROXY_PORT | Port | 443 | Https proxy bind port
NPS_WEB_USERNAME | String | admin | Web console user name
NPS_WEB_PASSWORD | String | 123 | Web console password
NPS_WEB_PORT | Port | 8080 | Web console bind port
NPS_HTTP_CACHE | Bool | false | Enable http static file cache
NPC_SERVER_ADDR | ServerAddr:BridgePort | 127.0.0.1:8024 | ServerAddr And bridge port for client
NPC_CONN_TYPE | tpc / udp | tcp | Bridge type for connect to server
NPC_VKEY | String | 123 | vkey for current client

## Usage

### Server

Start a nps server with admin port `8080`, connection port `8024` and reverse proxy port `80` and `443`, expose `8024` and `80` ports in your internet firewall or load balancer which resole `nps.example.com` to.

```sh
docker run -itd --name nps --net host --privileged -e NPS_MODE=server -e NPS_PUBLIC_VKEY=npS2022 -e NPS_WEB_PASSWORD=admin321 zhangsean/nps
```

Start a nps server with your customized config file.

```sh
# Copy origin config file
docker run -it --rm -v $PWD:/tmp zhangsean/nps cp -a conf /tmp/
# Modify nps.conf as your need
vi conf/nps.conf
# Run nps server with your own conf
docker run -itd --name nps --net host --privileged -v $PWD/conf:/nps/conf -e NPS_MODE=server zhangsean/nps nps
```

### Client

***WARING: Any nps client which connected with public vkey will lose all service after reconnecting.***

Open nps server web console with http://ip:8080, add a client then got it's special vkey `6exekiq8qkauw37t`.

Start a nps client, connect to server `nps.example.com`.

```sh
docker run -itd --name npc -e NPC_SERVER_ADDR=nps.example.com:8024 -e NPC_VKEY=6exekiq8qkauw37t zhangsean/nps
```

Or start a nps client with args.

```sh
docker run -itd --name npc zhangsean/nps npc -server=nps.example.com:8024 -vkey=6exekiq8qkauw37t -type=tcp
```

Or start a nps client with your customized config file.

```sh
# Copy origin config file
docker run -it --rm -v $PWD:/tmp zhangsean/nps cp conf/npc.conf /tmp/
# Modify nps.conf as your need
vi npc.conf
# Run nps server with your own conf
docker run -itd --name npc -v $PWD/npc.conf:/nps/conf/npc.conf zhangsean/nps npc
```

### Add service

Open the nps server web console with http://ip:8080, add some host forward or TCP forward service as your need.

### All in one

You can start nps server and client in one container for temp local forward.

```sh
docker run -itd --name nps --net host --privileged -e NPS_MODE=all -e NPS_WEB_PASSWORD=admin321 zhangsean/nps
```

***WARING: Any nps client which connected with public vkey will lose all service after reconnecting.***

## More

Please visit [ehang-io/nps](https://github.com/ehang-io/nps) for more.
