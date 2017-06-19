#!/bin/bash

source /etc/profile

cd $EB_APP_DEPLOY_DIR

mkdir -p /etc/dd-agent/checks.d
mkdir -p /etc/dd-agent/conf.d

# copy our configurations
[[ -d deployment/datadog/checks.d ]] && cp -R deployment/datadog/checks.d/* /etc/dd-agent/checks.d/
[[ -d deployment/datadog/conf.d ]] && cp -R deployment/datadog/conf.d/* /etc/dd-agent/conf.d/
[[ -f deployment/datadog/datadog.conf ]] && cp deployment/datadog/datadog.conf /etc/dd-agent/datadog.conf

# set new api key
[[ ! -z $DATADOG_API_KEY ]] && echo "api_key: $DATADOG_API_KEY" >>/etc/dd-agent/datadog.conf

/sbin/service datadog-agent stop || echo "datadog agent was not running"
/sbin/service datadog-agent start
