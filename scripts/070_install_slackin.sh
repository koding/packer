#!/bin/bash

set -o errexit

source /etc/profile

cd /usr/local
wget https://github.com/szkl/slackin/archive/too-many-requests.zip
unzip too-many-requests.zip
rm --force too-many-requests.zip
mv slackin-too-many-requests slackin

cd slackin
npm install --unsafe-perm
