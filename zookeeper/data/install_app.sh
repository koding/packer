#!/bin/bash -x

set -o errexit

#  make relative paths work.
cd $(dirname $0)/..

source /etc/profile
source $(dirname $0)/env.sh
export PATH=${JAVA_HOME}/bin:${PATH}

YUM="yum --assumeyes"



# INSTALL MAVEN
cd /usr/share
wget -q http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -O - | tar xzf -
mv /usr/share/apache-maven-${MAVEN_VERSION} $MAVEN_HOME
ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn

# INSTALL ZK
mkdir -p ${ZK_HOME} ${ZK_DATA_DIR} ${ZK_LOG_DIR}

curl -Lo /tmp/zookeeper.tgz ${ZK_RELEASE}
tar -xzf /tmp/zookeeper.tgz -C ${ZK_HOME} --strip-components=1
rm /tmp/zookeeper.tgz

# Install Exhibitor
mkdir -p ${EXBT_HOME}
curl -Lo ${EXBT_HOME}/pom.xml ${EXHIBITOR_POM}
mvn -f ${EXBT_HOME}/pom.xml package
ln -s ${EXBT_HOME}/target/exhibitor*jar ${EXBT_HOME}/exhibitor.jar

groupadd -r $ZK_USER
useradd -g $ZK_USER -M -r $ZK_USER

# set permissions for zookeeper
mkdir -p /var/{lib,log}/zookeeper
chown -R $ZK_USER:$ZK_USER /var/{lib,log}/zookeeper

mkdir -p /var/{lib,log}/exhibitor
chown -R $ZK_USER:$ZK_USER /var/{lib,log}/exhibitor

chown -R $ZK_USER:$ZK_USER ${ZK_HOME}
chown -R $ZK_USER:$ZK_USER ${ZK_DATA_DIR}
chown -R $ZK_USER:$ZK_USER ${ZK_LOG_DIR}


cat <<- EOF > $EXBT_HOME/defaults.conf
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

cat <<- EOF > $EXBT_HOME/credentials.properties
com.netflix.exhibitor.s3.access-key-id=${AWS_ACCESS_KEY}
com.netflix.exhibitor.s3.access-secret-key=${AWS_SECRET_KEY}
EOF
