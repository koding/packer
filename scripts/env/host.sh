#!/bin/bash -x

export HOST_IP=${HOST_IP:-`curl http://169.254.169.254/latest/meta-data/local-ipv4`}
export PRIVATE_IPV4=${PRIVATE_IPV4:-$HOST_IP}
