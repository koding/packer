#!/bin/bash

set -o errexit

# golang

curl --silent $GO_SRC_URL | tar --extract --gzip --directory=/usr/local

echo "export PATH=/usr/local/go/bin:\$PATH" >/etc/profile.d/golang.sh

source /etc/profile

go version
