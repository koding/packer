#!/bin/bash

# enable datadog repo
cp $(dirname $0)/data/yum.repos.d/datadog.repo /etc/yum.repos.d/datadog.repo

# move required files to etc folder.
cp -R $(dirname $0)/data/dd-agent /etc

yum makecache
yum install datadog-agent

source /etc/profile
pip install psutil psycopg2

service datadog-agent stop || :
