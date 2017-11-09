#!/bin/bash

yum clean all
rm -rf /tmp/* /var/tmp/*

sed --in-place --expression "/$(hostname)/ d" /etc/hosts
