#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

$YUM clean all && rm -rf /tmp/* /var/tmp/*
