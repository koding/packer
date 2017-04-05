#!/bin/bash

cd /usr/local/src
git clone https://github.com/nghttp2/nghttp2.git
cd nghttp2
git checkout tags/$HTTP2_VERSION
export CFLAGS="-g -O2 -fPIC" && export CPPFLAGS="-fPIC" && autoreconf -i && automake && autoconf && ./configure --disable-examples --disable-app && make && make install


# taken from
# https://github.com/koding/countly-server/blob/master/bin/scripts/install.nghttp2.sh#L43-L47
# https://github.com/Countly/countly-server/blob/8093c72714a28fc1757a582519d3011468c7fa5f/bin/scripts/install.nghttp2.sh#L43-L47
