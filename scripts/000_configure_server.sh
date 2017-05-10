#!/bin/bash

# yum

echo "assumeyes=1" >> /etc/yum.conf

# UPGRADE SYSTEM

yum update
yum upgrade

# System-wide configuration

ln -fs /usr/share/zoneinfo/UTC /etc/localtime

## Kernel parameters

### Network

cat - >/etc/sysctl.d/network.conf <<EOF
# Recycle network sockets in TIME_WAIT state
net.ipv4.tcp_tw_recycle = 1

# Reuse network sockets in TIME_WAIT state
net.ipv4.tcp_tw_reuse = 1

# Increase TIME_WAIT socket bucket count
net.ipv4.tcp_max_tw_buckets = 180000
EOF

sysctl -p /etc/sysctl.d/network.conf

## ulimit

echo '* - nofile 65535' >/etc/security/limits.d/nofile

echo "127.0.0.1     $HOSTNAME" >>/etc/hosts

mkdir -p /opt
mkdir -p /etc/sysconfig
mkdir -p /etc/profile.d

echo "pathmunge /usr/local/bin" >/etc/profile.d/local.sh
