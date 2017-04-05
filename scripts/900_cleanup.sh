#!/bin/bash

set -o errexit

$YUM clean all && rm -rf /tmp/* /var/tmp/*
