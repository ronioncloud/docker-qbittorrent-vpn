## docker-qbittorrent-vpn

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/qbittorrent-vpn) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/qbittorrent-vpn?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-qbittorrent-vpn/actions?query=workflow%3A"Auto+Builder+CI") [![codacy branch grade](https://img.shields.io/codacy/grade/0945a66870014049b337da44fb1e77e2/main?style=for-the-badge&logo=codacy)](https://app.codacy.com/gh/hydazz/docker-qbittorrent-vpn)

**This is an unofficial image that has been modified for my own needs. If my needs match your needs, feel free to use this image at your own risk.**

Fork of [guillaumedsde/alpine-qbittorrent-openvpn](https://github.com/guillaumedsde/alpine-qbittorrent-openvpn)

[qBittorrent](https://www.qbittorrent.org/) is a bittorrent client programmed in C++ / Qt that uses libtorrent (sometimes called libtorrent-rasterbar) by Arvid Norberg.

It aims to be a good alternative to all other bittorrent clients out there. qBittorrent is fast, stable and provides unicode support as well as many features.

## Usage

```bash
docker run -d \
  --name=qbittorrent-vpn \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e OPENVPN_USERNAME= #optional \
  -e OPENVPN_PASSWORD= #optional \
  -e LAN= #optional \
  -e DNS= #optional \
  -v <path to appdata>:/config \
  -v <path to downloads>:/downloads \
  --cap-add=NET_ADMIN \
  --restart unless-stopped \
  vcxpz/qbittorrent-vpn
```

[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/qbittorrent.xml)

## Environment Variables

Name               | Description                                                                              | Default Value
------------------ | ---------------------------------------------------------------------------------------- | ----------------------------------------------------------------------
`OPENVPN_USERNAME` | The accompying username for the OpenVPN config.                                          | No default, username must be manually set in `/config/credentials.txt`
`OPENVPN_PASSWORD` | The accompying password for the OpenVPN config.                                          | No default, password must be manually set in `/config/credentials.txt`
`LAN`              | Set this to the LAN subnet of the host. Leaving this default should work for most setups | `192.168.0.0/16`
`DNS`              | DNS server the container will use.                                                       | `1.1.1.1`

## Upgrading qBittorrent

To upgrade, all you have to do is pull the latest Docker image. We automatically check for qBittorrent updates every hour. When a new version is released, we build and publish an image both as a version tag and on `:latest`.

## Fixing Appdata Permissions

If you ever accidentally screw up the permissions on the appdata folder, run `fix-perms` within the container. This will restore most of the files/folders with the correct permissions.
