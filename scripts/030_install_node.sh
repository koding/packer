#!/bin/bash

# node.js

curl --silent $NODE_URL | tar --extract --xz --directory /usr/local
ln --symbolic --force /usr/local/$NODE_NAME/bin/* /usr/local/bin/
ln --symbolic --force /usr/local/bin/node /usr/local/bin/nodejs

echo "pathmunge /usr/local/share/npm/bin" >/etc/profile.d/npm.sh

# for commands below
source /etc/profile

## npm
# set npm to use a global place other than the installation path
npm config set prefix /usr/local

npm install --global npm@$NPM_VERSION

## CoffeeScript

npm install --global coffee-script@$COFFEE_VERSION

## gulp

npm install --global gulp@$GULP_VERSION
