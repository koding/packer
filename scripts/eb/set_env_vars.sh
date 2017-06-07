#!/bin/bash

set -o errexit

source /etc/profile

if [ -z $EB_ENV_NAME ]; then
	export EB_ENV_NAME=$(/opt/elasticbeanstalk/bin/get-config environment -k EB_ENV_NAME)
	[[ $EB_ENV_NAME == "" ]] && echo "EB_ENV_NAME" is empty && exit 1
	echo "export EB_ENV_NAME=$EB_ENV_NAME" >>/etc/profile.d/eb_envvars.sh
fi

if [ -z $EC2_INSTANCE_ID ]; then
	export EC2_INSTANCE_ID="$(/opt/aws/bin/ec2-metadata --instance-id | awk '{print $2}')"
	[[ $EC2_INSTANCE_ID == "" ]] && echo "EC2_INSTANCE_ID" is empty && exit 1
	echo "export EC2_INSTANCE_ID=$EC2_INSTANCE_ID" >>/etc/profile.d/ec2.sh
fi
