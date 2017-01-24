#!/bin/bash

#
# ENV variables for zookeeper
#
export ZK_HOME=${ZK_HOME:-/opt/zookeeper}
export ZK_VERSION=${ZK_VERSION:-3.4.8}
export ZK_RELEASE="http://www.apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz"
export ZK_DATA_DIR=${ZK_DATA_DIR:-$ZK_HOME/snapshots}
export ZK_LOG_DIR=${ZK_LOG_DIR:-$ZK_HOME/transactions}
export ZK_USER=${ZK_USER:-zookeeper}
export ZK_ENSEMBLE_SIZE=${ZK_ENSEMBLE_SIZE:-0}
