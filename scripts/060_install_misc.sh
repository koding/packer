#!/bin/bash

set -o errexit

source $(dirname $0)/export_env_vars.sh

# Miscellaneous

$YUM install graphviz

pip install psutil superlance
