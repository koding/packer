#!/bin/bash

pushd $(dirname $0)

./000_configure_server.sh
./010_install_utilities.sh
./010_install_setup_tools.sh
./020_install_nginx.sh
./030_install_node.sh
./040_install_go.sh
./050_install_pip.sh
./050_install_supervisor.sh
./060_install_misc.sh
./070_install_datadog.sh
./070_install_papertrail.sh
./900_cleanup.sh

popd

exit 0
