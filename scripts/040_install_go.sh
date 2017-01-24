#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

# golang

curl --silent $GO_SRC_URL | tar --extract --gzip --directory=/usr/local

echo "export PATH=/usr/local/go/bin:\$PATH" >/etc/profile.d/golang.sh

source /etc/profile

go version
