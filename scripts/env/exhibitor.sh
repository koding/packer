#!/bin/bash -x

export EXBT_HOME=${EXBT_HOME:-/opt/exhibitor}
export EXHIBITOR_POM="https://raw.githubusercontent.com/Netflix/exhibitor/d911a16d704bbe790d84bbacc655ef050c1f5806/exhibitor-standalone/src/main/resources/buildscripts/standalone/maven/pom.xml"

export EXBT_PORT=${EXBT_PORT:-8181}
export EXBT_LOGLINES=${EXBT_LOGLINES:-5000}
export EXBT_NODEMODIFICATION=${EXBT_NODEMODIFICATION:-true}
export EXBT_TIMEOUT=${EXBT_TIMEOUT:-30000}

export EXBT_AWS_REGION=${EXBT_AWS_REGION:-$AWS_REGION}
export EXBT_AWS_ACCESS_KEY=${EXBT_AWS_ACCESS_KEY:-$AWS_ACCESS_KEY}
export EXBT_AWS_SECRET_KEY=${EXBT_AWS_SECRET_KEY:-$AWS_SECRET_KEY}

export EXBT_S3_BACKUP=${EXBT_S3_BACKUP:-true}
export EXBT_S3_BACKUP_PATH=${EXBT_S3_BACKUP_PATH:-kodingdev-exhibitor:exhibitor}
export EXBT_S3_BACKUP_PREFIX=${EXBT_S3_BACKUP_PREFIX:-exhibitor-backup}

