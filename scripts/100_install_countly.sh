#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh


$YUM install gcc-c++-4.8.5 policycoreutils-python
$YUM install sendmail
service sendmail start

# from install.nghttp2.sh


cd /opt/countly

npm install -g node-gyp --unsafe-perm
npm install -g grunt-cli --unsafe-perm
npm install --unsafe-perm

# install plugins
node ./bin/scripts/install_plugins

# install sdk-web
./bin/scripts/update.sh sdk-web

# compile scripts for production
grunt dist-all

#configure and start nginx
useradd www-data
cp /etc/nginx/conf.d/default.conf ./bin/config/nginx.default.backup
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
