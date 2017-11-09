#!/bin/bash

yum clean all
rm -rf /tmp/* /var/tmp/*

grep -v $HOSTNAME /etc/hosts >/tmp/hosts
mv --force /tmp/hosts /etc/hosts
