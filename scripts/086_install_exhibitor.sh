#!/bin/bash -x

set -o errexit

source $(dirname $0)/export_env_vars.sh

# Install Exhibitor
mkdir -p ${EXBT_HOME}
curl -Lo ${EXBT_HOME}/pom.xml ${EXHIBITOR_POM}
mvn -f ${EXBT_HOME}/pom.xml package
ln -s ${EXBT_HOME}/target/exhibitor*jar ${EXBT_HOME}/exhibitor.jar

mkdir -p /var/{lib,log}/exhibitor
chown -R $ZK_USER:$ZK_USER /var/{lib,log}/exhibitor
