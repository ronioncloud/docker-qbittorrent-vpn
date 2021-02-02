## docker-qbittorrent-vpn

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/qbittorrent-vpn) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/qbittorrent-vpn?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-qbittorrent-vpn/actions?query=workflow%3A"Auto+Builder+CI") [![codacy branch grade](https://img.shields.io/codacy/grade/18a72af73f9349579e331188d3316b4c/main?style=for-the-badge&logo=codacy)](https://app.codacy.com/gh/hydazz/docker-qbittorrent-vpn)

Fork of [guillaumedsde/alpine-qbittorrent-openvpn](https://github.com/guillaumedsde/alpine-qbittorrent-openvpn)

[qBittorrent](https://www.qbittorrent.org/) is a bittorrent client programmed in C++ / Qt that uses libtorrent (sometimes called libtorrent-rasterbar) by Arvid Norberg.

It aims to be a good alternative to all other bittorrent clients out there. qBittorrent is fast, stable and provides unicode support as well as many features.

## Usage

    docker run -d \
      --name=qbittorrent-vpn \
      -e PUID=1000 \
      -e PGID=1000 \
      -e TZ=Australia/Melbourne \
      -e OPENVPN_USERNAME= `#optional` \
      -e OPENVPN_PASSWORD= `#optional` \
      -e LAN= `#optional` \
      -e DNS= `#optional` \
      -v <path to appdata>:/config \
      -v <path to downloads>:/downloads \
      --cap-add=NET_ADMIN \
      --restart unless-stopped \
      vcxpz/qbittorrent-vpn

## Environment Variables

| Name               | Description                                                                              | Default Value                                                          |
| ------------------ | ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| `OPENVPN_USERNAME` | The accompying username for the OpenVPN config.                                          | No default, username must be manually set in `/config/credentials.txt` |
| `OPENVPN_PASSWORD` | The accompying password for the OpenVPN config.                                          | No default, password must be manually set in `/config/credentials.txt` |
| `LAN`              | Set this to the LAN subnet of the host. Leaving this default should work for most setups | `192.168.0.0/24`                                                       |
| `DNS`              | DNS server the container will use.                                                       | `1.1.1.1`                                                              |

## Upgrading qBittorrent

To upgrade, all you have to do is pull the latest Docker image. We automatically check for qBittorrent updates daily so there may be some delay when an update is released to when the image is updated.
