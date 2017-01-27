#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

$YUM install git make binutils autoconf
$YUM install automake makedepend libtool
$YUM install pkgconfig zlib-devel libxml2-devel python-setuptools
