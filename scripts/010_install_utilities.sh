#!/bin/bash

# Core

yum install less patch which

# Extra Packages for Enterprise Linux (EPEL)

yum install epel-release
yum-config-manager --enable epel

# Archiving & Compression

yum install tar unzip

# Network

yum install telnet

yum install curl wget

# Version control

yum install git

# Text processor

yum install jq

# Misc

yum install htop
yum install dstat sysstat
