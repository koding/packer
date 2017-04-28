#!/bin/bash

# enable datadog repo
cp $(dirname $0)/data/yum.repos.d/datadog.repo /etc/yum.repos.d/datadog.repo

# move required files to etc folder.
cp -R $(dirname $0)/data/dd-agent /etc

mkdir --parents /opt/elasticbeanstalk/hooks/appdeploy/pre
mkdir --parents /opt/elasticbeanstalk/hooks/appdeploy/post

cp $(dirname $0)/data/dd-agent/hooks/99stop_datadog.sh /opt/elasticbeanstalk/hooks/appdeploy/pre/
cp $(dirname $0)/data/dd-agent/hooks/99start_datadog.sh /opt/elasticbeanstalk/hooks/appdeploy/post/

mkdir --parents /opt/elasticbeanstalk/hooks/configdeploy/pre
mkdir --parents /opt/elasticbeanstalk/hooks/configdeploy/post

cp $(dirname $0)/data/dd-agent/hooks/99stop_datadog.sh /opt/elasticbeanstalk/hooks/configdeploy/pre/
cp $(dirname $0)/data/dd-agent/hooks/99start_datadog.sh /opt/elasticbeanstalk/hooks/configdeploy/post/

mkdir --parents /opt/elasticbeanstalk/hooks/preinit
mkdir --parents /opt/elasticbeanstalk/hooks/postinit

cp $(dirname $0)/data/dd-agent/hooks/99stop_datadog.sh /opt/elasticbeanstalk/hooks/preinit/
cp $(dirname $0)/data/dd-agent/hooks/99start_datadog.sh /opt/elasticbeanstalk/hooks/postinit

yum makecache
yum install datadog-agent

source /etc/profile
pip install psutil

service datadog-agent stop || :
