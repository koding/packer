#!/bin/bash

set -o errexit

source /etc/profile

[[ -z $HOSTNAME ]] && echo "HOSTNAME" is required && exit 1
[[ -z $EB_ENV_NAME ]] && echo "EB_ENV_NAME" is required && exit 1

[[ -z $PAPERTRAIL_DESTINATION ]] && echo "PAPERTRAIL_DESTINATION" is required && exit 1
[[ -z $PAPERTRAIL_TOKEN ]] && echo "PAPERTRAIL_TOKEN" is required && exit 1

export PAPERTRAIL_URL=${PAPERTRAIL_URL:-"https://papertrailapp.com/api/v1/systems"}

export PAPERTRAIL_HOST=$(echo "$PAPERTRAIL_DESTINATION" | awk --field-separator ':' '{print $1}')
[[ $PAPERTRAIL_HOST == "" ]] && echo "PAPERTRAIL_HOST" is empty && exit 1

export PAPERTRAIL_PORT=$(echo "$PAPERTRAIL_DESTINATION" | awk --field-separator ':' '{print $2}')
[[ $PAPERTRAIL_PORT == "" ]] && echo "PAPERTRAIL_PORT" is empty && exit 1

# set the env vars for future use
echo "export PAPERTRAIL_HOST=$PAPERTRAIL_HOST" >/etc/profile.d/papertrail.sh
echo "export PAPERTRAIL_PORT=$PAPERTRAIL_PORT" >>/etc/profile.d/papertrail.sh

# copy our config
[[ -f $EB_APP_DEPLOY_DIR/.ebextensions/papertrail.yml ]] && cp $EB_APP_DEPLOY_DIR/.ebextensions/papertrail.yml /etc/log_files.yml && echo "copied log_files.yml"

CURL_PARAMS="--silent --output /dev/null --write-out %{http_code}"

restart() {
	echo "restarting papertrail.."
	/sbin/service remote_syslog stop || echo papertrail is not running
	/sbin/service remote_syslog start
}

# check if we already registered to papertrail
RESPONSE_CODE=$(curl $CURL_PARAMS -H "X-Papertrail-Token: $PAPERTRAIL_TOKEN" https://papertrailapp.com/api/v1/systems/$HOSTNAME.json)
if [[ $RESPONSE_CODE == 200 ]]; then
	echo "already registered to papertrail"
	restart
fi

# try registering to papertrail
RESPONSE_CODE=$(curl $CURL_PARAMS $PAPERTRAIL_URL -H "X-Papertrail-Token: $PAPERTRAIL_TOKEN" \
	--data "destination_port=${PAPERTRAIL_PORT}&system[name]=${HOSTNAME}&system[hostname]=${HOSTNAME}")
if [[ $? != 0 || $RESPONSE_CODE != 200 ]]; then
	echo "could not register to papertrail"
	exit 1
fi

restart
