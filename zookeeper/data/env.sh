

## HOST
export HOST_IP=${HOST_IP:-`curl http://169.254.169.254/latest/meta-data/local-ipv4`}

# SUPERVISORD CONFIGS
export SUPERVISORD_RUNDIR=${SUPERVISORD_RUNDIR:-/var/run}
export SUPERVISORD_LOGDIR=${SUPERVISORD_LOGDIR:-/var/log/zookeeper}
export SUPERVISORD_MINFDS=${SUPERVISORD_MINFDS:-10000}
export SUPERVISORD_MINPROCS=${SUPERVISORD_MINPROCS:-200}
export SUPERVISORD_UNIX_HTTP_SERVER_FILE=${SUPERVISORD_UNIX_HTTP_SERVER_FILE:-/var/run/supervisor.sock}

# AWS CONFIG
export AWS_REGION=${AWS_REGION:-us-east-1}
export AWS_ACCESS_KEY=${AWS_ACCESS_KEY:-***REMOVED***}
export AWS_SECRET_KEY=${AWS_SECRET_KEY:-afZaZz3Y+RmKNpfF7L3RrMh4qAW94zbFyA431INr}

# JAVA CONFIG
export JAVA_IO_TMP_DIR=${JAVA_IO_TMP_DIR:-/tmp}

# DRUID CONFIG
export ROOT_DIR=${ROOT_DIR:-/opt/zookeeper}

export JAVA_HOME="/usr/java/latest"

export ZK_HOME=${ZK_HOME:-/opt/zookeeper}
export ZK_VERSION=${ZK_VERSION:-3.4.8}
export ZK_RELEASE="http://www.apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz"
export ZK_DATA_DIR=${ZK_DATA_DIR:-$ZK_HOME/snapshots}
export ZK_LOG_DIR=${ZK_LOG_DIR:-$ZK_HOME/transactions}
export ZK_USER=${ZK_USER:-zookeeper}
export ZK_ENSEMBLE_SIZE=${ZK_ENSEMBLE_SIZE:-0}


export EXBT_HOME=${EXBT_HOME:-/opt/exhibitor}
export EXHIBITOR_POM="https://raw.githubusercontent.com/Netflix/exhibitor/d911a16d704bbe790d84bbacc655ef050c1f5806/exhibitor-standalone/src/main/resources/buildscripts/standalone/maven/pom.xml"
export EXBT_S3_BUCKET=${EXBT_S3_BUCKET:-koding-dev-test-exhibitor:zookeeper}
export EXBT_S3_BACKUP=${EXBT_S3_BACKUP:-true}
export EXBT_S3_BACKUP_PREFIX=${EXBT_S3_BACKUP_PREFIX:-zookeeper-backup}
export EXBT_PORT=${EXBT_PORT:-8181}

export MAVEN_HOME=${MAVEN_HOME:-/usr/share/maven}
export MAVEN_VERSION=${MAVEN_VERSION:-3.3.3}
