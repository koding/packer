#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

# nginx

$YUM install nginx
