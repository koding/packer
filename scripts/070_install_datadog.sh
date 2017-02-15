#!/bin/bash

source $(dirname $0)/export_env_vars.sh

$YUM install datadog-agent
service datadog-agent stop
