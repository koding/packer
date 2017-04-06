#!/bin/bash

# enable datadog repo
cp $(dirname $0)/data/yum.repos.d/datadog.repo /etc/yum.repos.d/datadog.repo

# move required files to etc folder.
cp -R $(dirname $0)/data/dd-agent /etc

mkdir /opt/elasticbeanstalk/hooks/appdeploy/post
mkdir /opt/elasticbeanstalk/hooks/appdeploy/pre

cp $(dirname $0)/data/dd-agent/hooks/99stop_datadog.sh /opt/elasticbeanstalk/hooks/appdeploy/pre/
cp $(dirname $0)/data/dd-agent/hooks/99start_datadog.sh /opt/elasticbeanstalk/hooks/appdeploy/post/

mkdir /opt/elasticbeanstalk/hooks/configdeploy/post
mkdir /opt/elasticbeanstalk/hooks/configdeploy/pre

cp $(dirname $0)/data/dd-agent/hooks/99stop_datadog.sh /opt/elasticbeanstalk/hooks/configdeploy/pre/
cp $(dirname $0)/data/dd-agent/hooks/99start_datadog.sh /opt/elasticbeanstalk/hooks/configdeploy/post/

mkdir /opt/elasticbeanstalk/hooks/post
mkdir /opt/elasticbeanstalk/hooks/pre

cp $(dirname $0)/data/dd-agent/hooks/99stop_datadog.sh /opt/elasticbeanstalk/hooks/preinit/
cp $(dirname $0)/data/dd-agent/hooks/99start_datadog.sh /opt/elasticbeanstalk/hooks/postinit

$YUM makecache
$YUM install datadog-agent
service datadog-agent stop
