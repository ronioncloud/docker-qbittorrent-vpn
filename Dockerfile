ARG TAG
FROM vcxpz/baseimage-alpine:${TAG}

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="qBittorrent version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

ENV QBT_WEBUI_PORT=8080 \
	LAN=192.168.0.0/16 \
	DOCKER_CIDR=172.17.0.0/16 \
	DNS=1.1.1.1 \
	S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN \
	echo "**** install build packages ****" && \
	apk add --no-cache --virtual=build-dependencies \
		libcap && \
	echo "**** install runtime packages ****" && \
	apk add --no-cache --upgrade \
		curl \
		iptables \
		jq \
		openvpn \
		subversion \
		sudo && \
	apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
		qbittorrent-nox && \
	setcap cap_net_admin+ep "$(which openvpn)" && \
	echo "abc ALL=(ALL)  NOPASSWD: /bin/ip" >>/etc/sudoers && \
	echo "**** cleanup ****" && \
	apk del --purge \
		build-dependencies && \
	rm -rf \
		/tmp/*

# add local files
COPY root/ /

# healthcheck
HEALTHCHECK --start-period=10s --interval=30s \
	CMD healthcheck

# ports and volumes
VOLUME /config
EXPOSE 8080
