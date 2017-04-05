#!/bin/bash

set -o errexit

# Logs

mkdir -p /var/log/supervisord
mkdir -p /var/log/koding

curl --silent --location $REMOTE_SYSLOG_TARBALL_URL | tar --verbose --extract --gzip --directory=/usr/local

cp $(dirname $0)/data/remote_syslog.init /etc/rc.d/init.d/remote_syslog

chkconfig --add remote_syslog
