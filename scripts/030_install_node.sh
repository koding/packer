#!/bin/bash -x

set -o errexit

source $(dirname $0)/export_env_vars.sh

# node.js

curl --silent $NODE_URL | tar --extract --xz --directory /usr/local
ln --symbolic /usr/local/$NODE_NAME/bin/* /usr/local/bin/

## npm

npm install --global npm@$NPM_VERSION

## CoffeeScript

npm install --global coffee-script@$COFFEE_VERSION

## gulp

npm install --global gulp@$GULP_VERSION
