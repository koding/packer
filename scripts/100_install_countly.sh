#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh


# check prerequisites
command -v aws >/dev/null 2>&1 || { echo "aws cli is required" && exit 1; }
[ -z "$AWS_ACCESS_KEY_ID" ] && echo "AWS_ACCESS_KEY_ID is required for aws cli" && exit 1
[ -z "$AWS_SECRET_ACCESS_KEY" ] && echo "AWS_SECRET_ACCESS_KEY is required for aws cli" && exit 1

$YUM install gcc-c++-4.8.5 policycoreutils-python
$YUM install sendmail
service sendmail start

aws s3 cp s3://$COUNTLY_S3_LINK countly.zip

unzip countly.zip -d /opt

cd /opt/countly

npm install -g node-gyp --unsafe-perm
npm install -g grunt-cli
npm install

#configure and start nginx
useradd www-data
# cp /etc/nginx/conf.d/default.conf ./bin/config/nginx.default.backup
mkdir -p /etc/nginx/conf.d
cp ./bin/config/nginx.server.conf /etc/nginx/conf.d/default.conf
cp ./bin/config/nginx.conf        /etc/nginx/nginx.conf
service nginx restart

# move countly's supervisord config
cp ./bin/config/supervisord.conf /etc/supervisord.conf

# configure countly.
cp ./frontend/express/public/javascripts/countly/countly.config.sample.js ./frontend/express/public/javascripts/countly/countly.config.js
cp ./api/config.sample.js ./api/config.js
cp ./frontend/express/config.sample.js ./frontend/express/config.js
cp ./plugins/plugins.default.json ./plugins/plugins.json


# install plugins
node ./bin/scripts/install_plugins

# install sdk-web
mkdir -p ./frontend/express/public/sdk/web;
# TODO(cihangir): we shouldnt use latest SDK and should pin. but sdk lacks our version ATM.
LATEST_SDK="$(wget -qO- https://api.github.com/repos/countly/countly-sdk-web/releases | grep tag_name | head -n 1 | cut -d '"' -f 4)"
npm install countly-sdk-web@$LATEST_SDK ;
cp -rf ./node_modules/countly-sdk-web/lib/* ./frontend/express/public/sdk/web/

# compile scripts for production
grunt dist-all
