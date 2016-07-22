#!/bin/bash -x

## Papertrail

export REMOTE_SYSLOG_VERSION="v0.16"
export REMOTE_SYSLOG_GITHUB_URL="https://github.com/papertrail/remote_syslog2"
export REMOTE_SYSLOG_FILENAME="remote_syslog_linux_amd64.tar.gz"
export REMOTE_SYSLOG_TARBALL_URL="$REMOTE_SYSLOG_GITHUB_URL/releases/download/$REMOTE_SYSLOG_VERSION/$REMOTE_SYSLOG_FILENAME"
