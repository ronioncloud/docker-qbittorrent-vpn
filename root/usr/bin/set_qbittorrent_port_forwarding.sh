#!/usr/bin/with-contenv bash

port="$1"

QBT_CONFIG_FILE="/config/qBittorrent/config/qBittorrent.conf"

if [ -f "$QBT_CONFIG_FILE" ]; then
	# if Connection address line exists
	if grep -q 'Connection\\PortRangeMin' "$QBT_CONFIG_FILE"; then
		# Set connection interface address to the VPN address
		sed -i -E 's/^.*\b(Connection.*PortRangeMin)\b.*$/Connection\\PortRangeMin='"$port"'/' "$QBT_CONFIG_FILE"
	else
		# add the line for configuring interface address to the qBittorrent config file
		printf 'Connection\\PortRangeMin=%s' "$port" >>"$QBT_CONFIG_FILE"
	fi
else
	# Create the configuration file from a template and environment variables
	printf '[Preferences]\nConnection\\PortRangeMin=%s\n' "$port" >"$QBT_CONFIG_FILE"
fi
