#!/bin/bash

set -o errexit

source /etc/profile

if [ -z $EB_ENV_NAME ]; then
	export EB_ENV_NAME=$(/opt/elasticbeanstalk/bin/get-config environment -k EB_ENV_NAME)
	[[ $EB_ENV_NAME == "" ]] && echo "EB_ENV_NAME" is empty && exit 1
	echo "export EB_ENV_NAME=$EB_ENV_NAME" >>/etc/profile.d/eb_envvars.sh
fi

if [ -z $EB_APP_DEPLOY_DIR ]; then
	export EB_APP_DEPLOY_DIR=$(/opt/elasticbeanstalk/bin/get-config container -k app_deploy_dir)
	[[ $EB_APP_DEPLOY_DIR == "" ]] && echo "EB_APP_DEPLOY_DIR" is empty && exit 1
	echo "export EB_APP_DEPLOY_DIR=$EB_APP_DEPLOY_DIR" >>/etc/profile.d/eb_envvars.sh
fi

if [ -z $EB_APP_SUPPORT_DIR ]; then
	export EB_APP_SUPPORT_DIR=$(/opt/elasticbeanstalk/bin/get-config container -k app_support_dir)
	[[ $EB_APP_SUPPORT_DIR == "" ]] && echo "EB_APP_SUPPORT_DIR" is empty && exit 1
	echo "export EB_APP_SUPPORT_DIR=$EB_APP_SUPPORT_DIR" >>/etc/profile.d/eb_envvars.sh
fi

if [ -z $EB_APP_USER ]; then
	export EB_APP_USER=$(/opt/elasticbeanstalk/bin/get-config container -k app_user)
	[[ $EB_APP_USER == "" ]] && echo "EB_APP_USER" is empty && exit 1
	echo "export EB_APP_USER=$EB_APP_USER" >>/etc/profile.d/eb_envvars.sh
fi

if [ -z $EC2_INSTANCE_ID ]; then
	export EC2_INSTANCE_ID="$(/opt/aws/bin/ec2-metadata --instance-id | awk '{print $2}')"
	[[ $EC2_INSTANCE_ID == "" ]] && echo "EC2_INSTANCE_ID" is empty && exit 1
	echo "export EC2_INSTANCE_ID=$EC2_INSTANCE_ID" >>/etc/profile.d/ec2.sh
fi
