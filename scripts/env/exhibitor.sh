#!/bin/bash -x

export EXBT_HOME=${EXBT_HOME:-/opt/exhibitor}
export EXHIBITOR_POM="https://raw.githubusercontent.com/Netflix/exhibitor/d911a16d704bbe790d84bbacc655ef050c1f5806/exhibitor-standalone/src/main/resources/buildscripts/standalone/maven/pom.xml"

export EXBT_S3_BUCKET=${EXBT_S3_BUCKET:-koding-dev-test-exhibitor:exhibitor}
export EXBT_S3_BACKUP_PREFIX=${EXBT_S3_BACKUP_PREFIX:-exhibitor-backup}

export EXBT_PORT=${EXBT_PORT:-8181}
export EXBT_S3_BACKUP=${EXBT_S3_BACKUP:-true}

export EXBT_AWS_ACCESS_KEY=${EXBT_AWS_ACCESS_KEY:-$AWS_ACCESS_KEY}
export EXBT_AWS_SECRET_KEY=${EXBT_AWS_SECRET_KEY:-$AWS_SECRET_KEY}
