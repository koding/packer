#!/bin/bash

set -o errexit

# Common packages

$YUM install telnet
$YUM install wget
$YUM install tar
$YUM install curl
$YUM install unzip
$YUM install which

$YUM install htop
$YUM install sysstat
$YUM install dstat
$YUM install jq # json parser

# Version controlling packages

$YUM install git patch
