#!/bin/bash

# Logs

mkdir -p /var/log/supervisord
mkdir -p /var/log/koding

curl --silent --location $REMOTE_SYSLOG_TARBALL_URL | tar --verbose --extract --gzip --directory=/usr/local

ln --symbolic /usr/local/remote_syslog/remote_syslog /usr/local/bin/remote_syslog

cp $(dirname $0)/data/remote_syslog.init /etc/rc.d/init.d/remote_syslog

chkconfig --add remote_syslog
