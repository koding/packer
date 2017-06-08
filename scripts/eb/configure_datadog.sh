#!/bin/bash

source /etc/profile

cd $EB_APP_DEPLOY_DIR

mkdir -p /etc/dd-agent/checks.d
mkdir -p /etc/dd-agent/conf.d

# copy our configurations
[[ -d .ebextensions/datadog/checks.d ]] && cp -R .ebextensions/datadog/checks.d/* /etc/dd-agent/checks.d/
[[ -d .ebextensions/datadog/conf.d ]] && cp -R .ebextensions/datadog/conf.d/* /etc/dd-agent/conf.d/
[[ -f .ebextensions/datadog/datadog.conf ]] && cp .ebextensions/datadog/datadog.conf /etc/dd-agent/datadog.conf

# set new api key
[[ ! -z $DATADOG_API_KEY ]] && echo "api_key: $DATADOG_API_KEY" >> /etc/dd-agent/datadog.conf

/etc/init.d/datadog-agent stop
/etc/init.d/datadog-agent start