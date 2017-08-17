#!/bin/bash

export NODE_VERSION=${NODE_VERSION:-"v8.4.0"}
export NODE_NAME="node-$NODE_VERSION-linux-x64"
export NODE_URL="https://nodejs.org/dist/$NODE_VERSION/$NODE_NAME.tar.xz"

export NPM_VERSION=${NPM_VERSION:-"4.0.5"}
export COFFEE_VERSION=${COFFEE_VERSION:-"1.12"}
export GULP_VERSION=${GULP_VERSION:-"3.9.0"}
