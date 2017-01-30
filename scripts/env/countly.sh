#!/bin/bash

export COUNTLY_VERSION=${COUNTLY_VERSION:-16.12.2}
export COUNTLY_S3_PATH=koding-backups/countly_enterprise_edition_$COUNTLY_VERSION.zip
export COUNTLY_S3_LINK=${COUNTLY_S3_LINK:-$COUNTLY_S3_PATH}
