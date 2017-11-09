#!/bin/bash

set -o xtrace

cd "$(dirname $0)" || exit 1
source ./export_env_vars.sh
./000_install_base.sh
./900_cleanup.sh
