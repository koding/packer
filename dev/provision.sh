#!/bin/bash

set -o xtrace

cd "$(dirname $0)" || exit 1
source ./export_env_vars.sh
./051_install_mongodb.sh
./051_install_postgresql.sh
./051_install_redis.sh
./900_cleanup.sh
