#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

wget -q $DRUID_RELEASE -O /tmp/druid.tar.gz
tar xfz /tmp/druid.tar.gz -C /opt
mv /opt/druid-* $DRUID_HOME

groupadd -r $DRUID_USER
useradd -g $DRUID_USER -M -r $DRUID_USER

# set permissions
mkdir -p $DRUID_HOME
mkdir -p $DRUID_LIB_DIR
mkdir -p $DRUID_LOG_DIR
mkdir -p $DRUID_SEGMENTCACHE_LOCATION

chown -R $DRUID_USER:$DRUID_USER $DRUID_HOME
chown -R $DRUID_USER:$DRUID_USER $DRUID_LIB_DIR
chown -R $DRUID_USER:$DRUID_USER $DRUID_LOG_DIR
chown -R $DRUID_USER:$DRUID_USER $DRUID_SEGMENTCACHE_LOCATION
