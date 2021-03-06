#!/bin/bash

export DRUID_HOME=${DRUID_HOME:-/opt/druid}
export DRUID_VERSION=${DRUID_VERSION:-0.9.1.1}
export DRUID_RELEASE="http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz"

export DRUID_LOG_DIR=${DRUID_LOG_DIR:-/var/log/druid}
export DRUID_LIB_DIR=${DRUID_LIB_DIR:-/var/lib/druid}

export DRUID_USER=${DRUID_USER:-druid}
export DRUID_ENSEMBLE_SIZE=${DRUID_ENSEMBLE_SIZE:-0}

#CONSTANTS

## MEMORY
export TOTAL_MEM__KB=$(cat /proc/meminfo | grep MemTotal | awk '{ print $2 }')
export TOTAL_MEM_MB=$(expr $TOTAL_MEM__KB / 1024)
export TOTAL_MEM_MB_Q1=$(expr $TOTAL_MEM_MB / 4)
export TOTAL_MEM_MB_Q1_STR=${TOTAL_MEM_MB_Q1}m
export TOTAL_MEM_MB_Q2=$(expr $TOTAL_MEM_MB / 2)
export TOTAL_MEM_MB_Q2_STR=${TOTAL_MEM_MB_Q2}m
export TOTAL_MEM_MB_10=$(expr $TOTAL_MEM_MB / 10)
export TOTAL_MEM_MB_10_STR=${TOTAL_MEM_MB_10}m
export TOTAL_MEM_MB_20=$(expr $TOTAL_MEM_MB / 20)
export TOTAL_MEM_MB_20_STR=${TOTAL_MEM_MB_20}m
export TOTAL_MEM_MB_40=$(expr $TOTAL_MEM_MB / 40)
export TOTAL_MEM_MB_40_STR=${TOTAL_MEM_MB_40}m
## CPU
export CPU_COUNT=$(nproc)
## DISC
export TOTAL_DISC_SIZE_IN_GB=${TOTAL_DISC_SIZE_IN_GB:-80}
export TOTAL_DISC_SIZE_IN_BYTES=$(expr $TOTAL_DISC_SIZE_IN_GB \* 1024 \* 1024 \* 1024)
## RUNTIME
export APPROX_NUM_THREADS=$(expr $CPU_COUNT - 1)
export APPROX_NUM_THREADS=$(expr $CPU_COUNT - 1)
export APPROX_NUM_HTTP_THREADS=$(expr $APPROX_NUM_THREADS \* 2)
export APPROX_NUM_HTTP_THREADS=$(expr $APPROX_NUM_THREADS \* 2)
export APPROX_NUM_HTTP_CONNECTIONS=$APPROX_NUM_THREADS
export APPROX_NUM_HTTP_CONNECTIONS=$APPROX_NUM_THREADS
## HOST
export HOST_IP=${HOST_IP:-$(curl http://169.254.169.254/latest/meta-data/local-ipv4)}

# AWS CONFIG
export AWS_ACCESS_KEY=${AWS_ACCESS_KEY:-diurd}
export AWS_SECRET_KEY=${AWS_SECRET_KEY:-diurd}

export DRUID_AWS_ACCESS_KEY=${DRUID_AWS_ACCESS_KEY:-""}
export DRUID_AWS_SECRET_KEY=${DRUID_AWS_SECRET_KEY:-""}

# JAVA CONFIG
export JAVA_IO_TMP_DIR=${JAVA_IO_TMP_DIR:-/tmp}

export JAVA_XXMaxDirectMemorySize=${JAVA_XXMaxDirectMemorySize:-$TOTAL_MEM_MB_10}
export JAVA_XXMaxDirectMemorySize_STR=${JAVA_XXMaxDirectMemorySize}m

# DRUID CONFIG
export DRUID_ROOT=${DRUID_ROOT:-/opt/druid}

## auto generated buffer size configs
export APPROX_DRUID_PROCESSING_BUFFER_MB=$(expr $JAVA_XXMaxDirectMemorySize / $CPU_COUNT)
export DRUID_PROCESSING_BUFFER_MB=${DRUID_PROCESSING_BUFFER_MB:-$APPROX_DRUID_PROCESSING_BUFFER_MB}
export APPROX_DRUID_PROCESSING_BUFFER_BYTES=$(expr $DRUID_PROCESSING_BUFFER_MB \* 1024 \* 1024)
export DRUID_PROCESSING_BUFFER_BYTES=${DRUID_PROCESSING_BUFFER_BYTES:-$APPROX_DRUID_PROCESSING_BUFFER_BYTES}

export DRUID_METADATA_STORAGE_TYPE=${DRUID_METADATA_STORAGE_TYPE:-postgresql}
export DRUID_METADATA_STORAGE_CONN_STR=${DRUID_METADATA_STORAGE_CONN_STR:-druidtest.cng7ujlhbcud.us-east-1.rds.amazonaws.com:5432/druid}
export DRUID_METADATA_STORAGE_USER=${DRUID_METADATA_STORAGE_USER:-druidtestmaster}
export DRUID_METADATA_STORAGE_PASS=${DRUID_METADATA_STORAGE_PASS:-druidtestmaster}

export DRUID_PROCESSING_NUM_THREADS=${DRUID_PROCESSING_NUM_THREADS:-$APPROX_NUM_THREADS}
export DRUID_PROCESSING_BUFFER_SIZEBYTES=${DRUID_PROCESSING_BUFFER_SIZEBYTES:-$DRUID_PROCESSING_BUFFER_BYTES}
export DRUID_SERVER_HTTP_NUM_THREADS=${DRUID_SERVER_HTTP_NUM_THREADS:-$APPROX_NUM_HTTP_THREADS}
export DRUID_SERVER_HTTP_NUM_CONNECTIONS=${DRUID_SERVER_HTTP_NUM_CONNECTIONS:-$APPROX_NUM_HTTP_CONNECTIONS}
export DRUID_WORKER_CAPACITY=${DRUID_WORKER_CAPACITY:-9}
export DRUID_SEGMENTCACHE_LOCATION=${DRUID_SEGMENTCACHE_LOCATION:-/data/druid/indexCache}

export DRUID_OVERLORD_Xmx=${DRUID_OVERLORD_Xmx:-$TOTAL_MEM_MB_Q1_STR}
export DRUID_OVERLORD_Xms=${DRUID_OVERLORD_Xms:-$TOTAL_MEM_MB_Q1_STR}
export DRUID_OVERLORD_XXNewSize=${DRUID_OVERLORD_XXNewSize:-$TOTAL_MEM_MB_40_STR}
export DRUID_OVERLORD_XXMaxNewSize=${DRUID_OVERLORD_XXMaxNewSize:-$TOTAL_MEM_MB_40_STR}

export DRUID_MIDDLEMANAGER_Xmx=${DRUID_MIDDLEMANAGER_Xmx:-$TOTAL_MEM_MB_Q1_STR}
export DRUID_MIDDLEMANAGER_Xms=${DRUID_MIDDLEMANAGER_Xms:-$TOTAL_MEM_MB_Q1_STR}

export DRUID_STORAGE_BUCKET=${DRUID_STORAGE_BUCKET:-koding-druid}
export DRUID_STORAGE_BASE_KEY=${DRUID_STORAGE_BASE_KEY:-prod/storage/v1}
export DRUID_STORAGE_ARCHIVE_BUCKET=${DRUID_STORAGE_ARCHIVE_BUCKET:-koding-druid-archive}
export DRUID_STORAGE_ARCHIVE_BASE_KEY=${DRUID_STORAGE_ARCHIVE_BASE_KEY:-$DRUID_STORAGE_BASE_KEY}

export DRUID_INDEXER_LOGS_S3_BUCKET=${DRUID_INDEXER_LOGS_S3_BUCKET:-$DRUID_STORAGE_BUCKET}
export DRUID_INDEXER_LOGS_S3_PREFIX=${DRUID_INDEXER_LOGS_S3_PREFIX:-prod/logs/v1}

export DRUID_COORDINATOR_Xmx=${DRUID_COORDINATOR_Xmx:-$TOTAL_MEM_MB_Q2_STR}
export DRUID_COORDINATOR_Xms=${DRUID_COORDINATOR_Xms:-$TOTAL_MEM_MB_Q2_STR}
export DRUID_COORDINATOR_XXNewSize=${DRUID_COORDINATOR_XXNewSize:-$TOTAL_MEM_MB_20_STR}
export DRUID_COORDINATOR_XXMaxNewSize=${DRUID_COORDINATOR_XXMaxNewSize:-$TOTAL_MEM_MB_20_STR}

export DRUID_HISTORICAL_Xmx=${DRUID_HISTORICAL_Xmx:-$TOTAL_MEM_MB_20_STR}
export DRUID_HISTORICAL_Xms=${DRUID_HISTORICAL_Xms:-$TOTAL_MEM_MB_20_STR}
export DRUID_HISTORICAL_XXNewSize=${DRUID_HISTORICAL_XXNewSize:-$TOTAL_MEM_MB_40_STR}
export DRUID_HISTORICAL_XXMaxNewSize=${DRUID_HISTORICAL_XXMaxNewSize:-$TOTAL_MEM_MB_40_STR}
export DRUID_HISTORICAL_XXMaxDirectMemorySize=${DRUID_HISTORICAL_XXMaxDirectMemorySize:-$JAVA_XXMaxDirectMemorySize_STR}

export DRUID_BROKER_PORT=${DRUID_BROKER_PORT:-8082}
export DRUID_BROKER_Xmx=${DRUID_BROKER_Xmx:-$TOTAL_MEM_MB_10_STR}
export DRUID_BROKER_Xms=${DRUID_BROKER_Xms:-$TOTAL_MEM_MB_10_STR}
export DRUID_BROKER_XXNewSize=${DRUID_BROKER_XXNewSize:-$TOTAL_MEM_MB_40_STR}
export DRUID_BROKER_XXMaxNewSize=${DRUID_BROKER_XXMaxNewSize:-$TOTAL_MEM_MB_40_STR}
export DRUID_BROKER_XXMaxDirectMemorySize=${DRUID_BROKER_XXMaxDirectMemorySize:-$JAVA_XXMaxDirectMemorySize_STR}
export DRUID_BROKER_RETRY_COUNT=${DRUID_BROKER_RETRY_COUNT:-3}
export DRUID_BROKER_MAXINTERMEDIATEROWS=${DRUID_BROKER_MAXINTERMEDIATEROWS:-50000}
export DRUID_BROKER_MAXRESULTS=${DRUID_BROKER_MAXRESULTS:-50000}
export DRUID_BROKER_MAXSEARCHLIMIT=${DRUID_BROKER_MAXSEARCHLIMIT:-1000}

export DRUID_REALTIME_Xmx=${DRUID_REALTIME_Xmx:-$TOTAL_MEM_MB_20_STR}
export DRUID_REALTIME_Xms=${DRUID_REALTIME_Xms:-$TOTAL_MEM_MB_20_STR}
export DRUID_REALTIME_XXNewSize=${DRUID_REALTIME_XXNewSize:-$TOTAL_MEM_MB_40_STR}
export DRUID_REALTIME_XXMaxNewSize=${DRUID_REALTIME_XXMaxNewSize:-$TOTAL_MEM_MB_40_STR}
export DRUID_REALTIME_XXMaxDirectMemorySize=${DRUID_REALTIME_XXMaxDirectMemorySize:-$JAVA_XXMaxDirectMemorySize_STR}
