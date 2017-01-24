#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

# download kafka
curl -sS https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/$KAFKA_RELEASE.tgz -o /opt/kafka.tgz

cd /opt && tar zxf kafka.tgz && rm kafka.tgz
mv /opt/kafka_* $KAFKA_HOME

cp $(dirname $0)/data/kafka.init /etc/rc.d/init.d/kafka

groupadd -r $KAFKA_USER
useradd -g $KAFKA_USER -M -r $KAFKA_USER

# set permissions for kafka
mkdir -p $KAFKA_HOME
mkdir -p $KAFKA_LIB_DIR
mkdir -p $KAFKA_LOG_DIR

chown -R $KAFKA_USER:$KAFKA_USER $KAFKA_HOME
chown -R $KAFKA_USER:$KAFKA_USER $KAFKA_LIB_DIR
chown -R $KAFKA_USER:$KAFKA_USER $KAFKA_LOG_DIR

chmod +x /etc/rc.d/init.d/kafka
chkconfig --add kafka
