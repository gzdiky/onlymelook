#!/bin/bash
# Written by FalsePhilosopher
opkg update
opkg install unzip coreutils-rm libpcap1
cd /tmp
wget https://github.com/gzdiky/onlymelook/archive/refs/heads/main.zip -O /tmp/main.zip && unzip -o -j /tmp/main.zip -d /tmp/upload && opkg install /tmp/upload/libpcap1 /tmp/upload/pppwn.ipk /tmp/upload/luci-pppwn.ipk /tmp/upload/cloudflared.ipk
rm main.zip
