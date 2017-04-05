#!/bin/bash

cat <<-EOF >$EXBT_HOME/defaults.conf
zookeeper-data-directory=$ZK_DATA_DIR
zookeeper-install-directory=$ZK_HOME
zookeeper-log-directory=$ZK_LOG_DIR
log-index-directory=$ZK_LOG_DIR
cleanup-period-ms=300000
check-ms=30000
backup-period-ms=600000
client-port=2181
cleanup-max-files=20
backup-max-store-ms=21600000
connect-port=2888
observer-threshold=0
election-port=3888
zoo-cfg-extra=tickTime\=2000&initLimit\=10&syncLimit\=5&quorumListenOnAllIPs\=true
auto-manage-instances-settling-period-ms=0
auto-manage-instances=1
auto-manage-instances-fixed-ensemble-size=$ZK_ENSEMBLE_SIZE
backup-extra=throttle\=&bucket-name\=$EXBT_S3_BUCKET&key-prefix\=$EXBT_S3_BACKUP_PREFIX&max-retries\=4&retry-sleep-ms\=30000
EOF

cat <<-EOF >$EXBT_HOME/credentials.properties
com.netflix.exhibitor.s3.access-key-id=${EXBT_AWS_ACCESS_KEY}
com.netflix.exhibitor.s3.access-secret-key=${EXBT_AWS_SECRET_KEY}
EOF
