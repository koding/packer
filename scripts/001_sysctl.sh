#!/bin/bash

# Kernel parameters

## Network

cat - >/etc/sysctl.d/network.conf <<EOF
# Recycle network sockets in TIME_WAIT state
net.ipv4.tcp_tw_recycle = 1

# Reuse network sockets in TIME_WAIT state
net.ipv4.tcp_tw_reuse = 1

# Increase TIME_WAIT socket bucket count
net.ipv4.tcp_max_tw_buckets = 180000
EOF

sysctl -p /etc/sysctl.d/network.conf

# ulimit

echo 'fs.file-max = 2000000' >/etc/sysctl.d/file-max.conf
sysctl -p /etc/sysctl.d/file-max.conf

# user/process specific limits
echo '* soft nofile 65000' >/etc/security/limits.d/nofile.conf
echo '* hard nofile 65000' >>/etc/security/limits.d/nofile.conf
echo 'root soft nofile 65000' >>/etc/security/limits.d/nofile.conf
echo 'root hard nofile 65000' >>/etc/security/limits.d/nofile.conf
