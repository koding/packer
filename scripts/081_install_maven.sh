#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

cd /usr/share
wget -q http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -O - | tar xzf -
mv /usr/share/apache-maven-${MAVEN_VERSION} $MAVEN_HOME
ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn
