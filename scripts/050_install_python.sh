#!/bin/bash

source /etc/profile

yum install python27 python27-devel python27-pip || :

pip install --upgrade pip==$PIP_VER
