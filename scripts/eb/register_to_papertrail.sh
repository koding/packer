#!/bin/bash

set -o errexit

source /etc/profile

[[ -z $HOSTNAME ]] && echo "HOSTNAME" is required && exit 1
[[ -z $EB_ENV_NAME ]] && echo "EB_ENV_NAME" is required && exit 1

[[ -z $KONFIG_PAPERTRAIL_DESTINATION ]] && echo "KONFIG_PAPERTRAIL_DESTINATION" is required && exit 1
[[ -z $KONFIG_PAPERTRAIL_TOKEN ]] && echo "KONFIG_PAPERTRAIL_TOKEN" is required && exit 1

export PAPERTRAIL_URL=${PAPERTRAIL_URL:-"https://papertrailapp.com/api/v1/systems"}

export PAPERTRAIL_PORT=$(echo "$KONFIG_PAPERTRAIL_DESTINATION" | awk --field-separator ':' '{print $2}')
[[ $PAPERTRAIL_PORT == "" ]] && echo "PAPERTRAIL_PORT" is empty && exit 1


curl_params="--silent --output /dev/null --write-out %{http_code}"

# check if we already registered to papertrail
RESPONSE_CODE=$(curl $curl_params -H "X-Papertrail-Token: $KONFIG_PAPERTRAIL_TOKEN" https://papertrailapp.com/api/v1/systems/$HOSTNAME.json)
if [[ $RESPONSE_CODE == 200 ]]; then
	echo "already registered to papertrail"
	exit 0
fi

# try registering to papertrail
RESPONSE_CODE=$(curl $curl_params $PAPERTRAIL_URL -H "X-Papertrail-Token: $KONFIG_PAPERTRAIL_TOKEN" \
	--data "destination_port=${PAPERTRAIL_PORT}&system[name]=${HOSTNAME}&system[hostname]=${HOSTNAME}")
if [[ $? != 0 || $RESPONSE_CODE != 200 ]]; then
	echo "could not register to papertrail"
	exit 1
fi
