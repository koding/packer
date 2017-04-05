#!/bin/bash

set -o errexit

# node.js

curl --silent $NODE_URL | tar --extract --xz --directory /usr/local
ln --symbolic /usr/local/$NODE_NAME/bin/* /usr/local/bin/
ln --symbolic /usr/local/bin/node /usr/local/bin/nodejs

[[ ":$PATH:" != */usr/local/bin* ]] &&  echo 'export PATH="/usr/local/bin:${PATH}"' >>/etc/profile.d/local_bin.sh
[[ ":$PATH:" != */usr/local/share/npm/bin* ]] && echo 'export PATH="/usr/local/share/npm/bin:${PATH}"' >>/etc/profile.d/npm_bin.sh

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
