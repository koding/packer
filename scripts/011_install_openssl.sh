#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

$YUM install openssl-devel

wget https://openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
tar -zxvf openssl-$OPENSSL_VERSION.tar.gz -C /usr/local/src
cd /usr/local/src/openssl-$OPENSSL_VERSION
./config --prefix=/usr
make depend
make
make install
