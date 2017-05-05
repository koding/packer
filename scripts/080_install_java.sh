#!/bin/bash

YUM="yum --assumeyes"

JAVA_HOME="/usr/java/latest"
JAVA_VERSION=8u102
BUILD_VERSION=b14
JAVA_RPM=jdk-$JAVA_VERSION-linux-x64.rpm

# INSTALL JAVA
wget --no-cookies --no-check-certificate \
	--header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
	"http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/$JAVA_RPM"

set +o errexit
$YUM localinstall $JAVA_RPM
rm -rf $JAVA_RPM
yum clean all
set -o errexit

alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000
alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000
alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
alternatives --install /usr/bin/jps jps /usr/java/latest/bin/jps 200000

# It's NOT a good idea to change /etc/profile unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to the environment, as this
# will prevent the need for merging in future updates.
echo "export JAVA_HOME=$JAVA_HOME" >>/etc/profile.d/java.sh
echo 'export PATH=$JAVA_HOME/bin:$PATH' >>/etc/profile.d/java.sh
# on the other hand /etc/profile.d/eb_envvars.sh uses /usr/java/latest as
# JAVA_HOME if directory is present

# IN CASE OF NETWORK CHANGES, DO NOT CACHE THE IP FOREVER.
grep '^networkaddress.cache.ttl=' ${JAVA_HOME}/jre/lib/security/java.security || echo 'networkaddress.cache.ttl=60' >>${JAVA_HOME}/jre/lib/security/java.security

source /etc/profile

java -version
