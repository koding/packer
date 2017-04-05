#!/bin/bash

# INSTALL PYTHON AND SUPERVISORD - on some systems some of the below does not exist.
$YUM install python26-pip || echo python26-pip installed
$YUM install python-pip || echo python-pip installed
$YUM install python-devel || echo python-devel installed
$YUM install python-setuptools || echo python-setuptools installed

source /etc/profile

easy_install --upgrade pip==$PIP_VER

echo "export PATH=/usr/local/bin:\$PATH" >/etc/profile.d/local_bin.sh

source /etc/profile
