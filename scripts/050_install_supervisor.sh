#!/bin/bash

source /etc/profile

pip install supervisor==$SUPERVISORD_VERSION
pip install superlance

# fix random failures
[ -f /usr/bin/supervisorctl ] || ln --symbolic --force /usr/local/bin/supervisorctl /usr/bin/supervisorctl
[ -f /usr/bin/supervisord ] || ln --symbolic --force /usr/local/bin/supervisord /usr/bin/supervisord

mkdir -p /var/log/supervisord/
mkdir -p /etc/sysconfig/

cp $(dirname $0)/data/supervisord.init /etc/rc.d/init.d/supervisord
chmod +x /etc/rc.d/init.d/supervisord
chkconfig --add supervisord
