#!/bin/bash

# golang

curl --silent $GO_SRC_URL | tar --extract --gzip --directory=/usr/local

echo "pathmunge /usr/local/go/bin" >/etc/profile.d/golang.sh

source /etc/profile

go version
