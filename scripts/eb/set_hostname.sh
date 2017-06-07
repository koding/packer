#!/bin/bash

set -o errexit

# we need EB_ENV_NAME
source "$(dirname "$0")"/set_env_vars.sh

[[ -z $EB_ENV_NAME ]] && echo "EB_ENV_NAME" is required && exit 1
[[ -z $EC2_INSTANCE_ID ]] && echo "EC2_INSTANCE_ID" is required && exit 1

export HOSTNAME="$EB_ENV_NAME"-"$EC2_INSTANCE_ID"

# set the hostname
echo "$HOSTNAME" >/etc/hostname
hostname -F /etc/hostname

hostnameStr="127.0.0.1  $HOSTNAME"
grep "^$hostnameStr" /etc/hosts || echo "$hostnameStr" >>/etc/hosts
