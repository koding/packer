#!/bin/bash

source /etc/profile

cd /opt/countly

npm install

#configure and start nginx
useradd www-data
# cp /etc/nginx/conf.d/default.conf ./bin/config/nginx.default.backup
mkdir -p /etc/nginx/conf.d
cp ./bin/config/nginx.server.conf /etc/nginx/conf.d/default.conf
cp ./bin/config/nginx.conf /etc/nginx/nginx.conf
service nginx restart || :

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
mkdir -p ./frontend/express/public/sdk/web
# TODO(cihangir): we shouldnt use latest SDK and should pin. but sdk lacks our version ATM.
LATEST_SDK="$(npm info countly-sdk-web version)"
npm install countly-sdk-web@$LATEST_SDK
cp -rf ./node_modules/countly-sdk-web/lib/* ./frontend/express/public/sdk/web/

# compile scripts for production
grunt dist-all
