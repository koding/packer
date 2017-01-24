#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

# INSTALL ZK
mkdir -p ${ZK_HOME} ${ZK_DATA_DIR} ${ZK_LOG_DIR}

curl -Lo /tmp/zookeeper.tgz ${ZK_RELEASE}
tar -xzf /tmp/zookeeper.tgz -C ${ZK_HOME} --strip-components=1
rm /tmp/zookeeper.tgz

groupadd -r $ZK_USER
useradd -g $ZK_USER -M -r $ZK_USER

# set permissions for zookeeper
mkdir -p /var/{lib,log}/zookeeper
chown -R $ZK_USER:$ZK_USER /var/{lib,log}/zookeeper

chown -R $ZK_USER:$ZK_USER ${ZK_HOME}
chown -R $ZK_USER:$ZK_USER ${ZK_DATA_DIR}
chown -R $ZK_USER:$ZK_USER ${ZK_LOG_DIR}
