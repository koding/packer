#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

cd /usr/local/src
git clone https://github.com/nghttp2/nghttp2.git
cd nghttp2
git checkout tags/$HTTP2_VERSION
export CFLAGS="-g -O2 -fPIC" && export CPPFLAGS="-fPIC" && autoreconf -i && automake && autoconf && ./configure --disable-examples --disable-app && make && make install
