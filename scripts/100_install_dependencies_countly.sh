#!/bin/bash

source /etc/profile

# check prerequisites
command -v aws >/dev/null 2>&1 || { echo "aws cli is required" && exit 1; }
[ -z "$AWS_ACCESS_KEY_ID" ] && echo "AWS_ACCESS_KEY_ID is required for aws cli" && exit 1
[ -z "$AWS_SECRET_ACCESS_KEY" ] && echo "AWS_SECRET_ACCESS_KEY is required for aws cli" && exit 1

yum install gcc-c++-4.8.5 policycoreutils-python
yum install sendmail
service sendmail start || :

npm install --unsafe-perm --global node-gyp
npm install --unsafe-perm --global grunt-cli

# download countly server.
mkdir -p /opt
aws s3 cp s3://$COUNTLY_S3_LINK countly.zip
unzip countly.zip -d /opt
rm -rf countly.zip

# download custom plugins for countly.
mkdir countly-plugins
aws s3 cp s3://$COUNTLY_S3_PLUGIN_PATH ./countly-plugins --recursive
# do not override existing plugins, but add new ones if necessary
unzip -n ./countly-plugins/*.zip -d /opt/countly/plugins
rm -rf countly-plugins
