#!/bin/bash -x

set -o errexit

source $(dirname $0)/export_env_vars.sh

# node.js

$YUM --enablerepo=epel install nodejs-$NODE_VERSION

## npm

$YUM --enablerepo=epel install npm

npm install --global npm@$NPM_VERSION

## CoffeeScript

npm install --global coffee-script@$COFFEE_VERSION

## gulp

npm install --global gulp@$GULP_VERSION
