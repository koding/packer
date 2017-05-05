#!/bin/bash

$YUM install openssl-devel

wget https://openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
tar -zxvf openssl-$OPENSSL_VERSION.tar.gz -C /usr/local/src
cd /usr/local/src/openssl-$OPENSSL_VERSION

set +o errexit
set +o xtrace

./config --prefix=/usr
make depend
make
make install
