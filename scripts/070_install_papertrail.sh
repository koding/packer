#!/bin/bash -x

set -o errexit

source $(dirname $0)/export_env_vars.sh

# Logs

mkdir -p /var/log/supervisord
mkdir -p /var/log/koding

curl --silent --location $REMOTE_SYSLOG_TARBALL_URL | tar --verbose --extract --gzip --directory=/usr/local

# TODO WHERE IS INIT>D FILE???

chkconfig --add remote_syslog
