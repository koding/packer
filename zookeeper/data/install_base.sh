#!/bin/bash

set -o errexit

YUM="yum --assumeyes"

JAVA_HOME="/usr/java/latest"
JAVA_VERSION=8u102
BUILD_VERSION=b14
JAVA_RPM=jdk-$JAVA_VERSION-linux-x64.rpm


# UPGRADE SYSTEM
$YUM update
$YUM upgrade

# INSTALL DEPENDENCIES
$YUM install wget
$YUM install tar
$YUM install curl

# INSTALL JAVA
wget --no-cookies --no-check-certificate \
--header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/$JAVA_RPM"

yum localinstall -y $JAVA_RPM
rm -rf $JAVA_RPM
yum clean all

alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000
alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000
alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
alternatives --install /usr/bin/jps jps /usr/java/latest/bin/jps 200000

# It's NOT a good idea to change /etc/profile unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to the environment, as this
# will prevent the need for merging in future updates.
echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile.d/java.sh
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/java.sh
# on the other hand /etc/profile.d/eb_envvars.sh uses /usr/java/latest as
# JAVA_HOME if directory is present

# IN CASE OF NETWORK CHANGES, DO NOT CACHE THE IP FOREVER.
grep '^networkaddress.cache.ttl=' ${JAVA_HOME}/jre/lib/security/java.security || echo 'networkaddress.cache.ttl=60' >> ${JAVA_HOME}/jre/lib/security/java.security

# ADD HOSTNAME INTO HOSTS FILE
echo "127.0.0.1     $HOSTNAME" >> /etc/hosts
source /etc/profile

# INSTALL PYTHON AND SUPERVISORD - on some systems some of the below does not exist.
$YUM install python26-pip || echo python26-pip installed
$YUM install python-pip || echo python-pip installed
$YUM install python-devel || echo python-devel installed

pip install --upgrade pip
pip install supervisor==3.2.0

mkdir -p /var/log/supervisord/
mkdir -p /etc/sysconfig/
