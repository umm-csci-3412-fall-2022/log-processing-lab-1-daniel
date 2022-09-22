#!/usr/bin/env bash

LOG_DIR=$1
WORKING_DIR=$(pwd)
for f in $(ls ${WORKING_DIR}/${LOG_DIR}/*.tgz); do
	zcat "$f" | tail -n +2
done | gzip -c > ${WORKING_DIR}/LOG_DIR/combined_logs.tgz
