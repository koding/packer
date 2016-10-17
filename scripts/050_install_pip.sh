#!/bin/bash -x

set -o errexit

source $(dirname $0)/export_env_vars.sh

# INSTALL PYTHON AND SUPERVISORD - on some systems some of the below does not exist.
$YUM install python26-pip || echo python26-pip installed
$YUM install python-pip || echo python-pip installed
$YUM install python-devel || echo python-devel installed

pip install --upgrade pip==$PIP_VERSION

echo "export PATH=/usr/local/bin:\$PATH" > /etc/profile.d/local_bin.sh

source /etc/profile

pip --version
