#!/bin/bash

# yum

echo "assumeyes=1" >>/etc/yum.conf

# UPGRADE SYSTEM

yum update
yum upgrade

# System-wide configuration

ln --symbolic --force /usr/share/zoneinfo/UTC /etc/localtime

mkdir -p /opt
mkdir -p /etc/sysconfig
mkdir -p /etc/profile.d

./001_sysctl.sh

## hosts file

# NOTE: this might stay in hosts file after system installation is done. If you
# want to keep your hosts file up-to-date, do not forget to add 900_cleanup.sh
# in your installation template
echo "127.0.0.1     $HOSTNAME" >>/etc/hosts

echo "pathmunge /usr/local/bin" >/etc/profile.d/local.sh
