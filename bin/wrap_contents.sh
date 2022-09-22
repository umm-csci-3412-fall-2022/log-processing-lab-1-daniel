#!/usr/bin/env bash

INPUT_FILE=$1
SPECIFIER=$2
OUTPUT_FILE=$3

cat "${SPECIFIER}_header.html" $INPUT_FILE "${SPECIFIER}_footer.html" > $OUTPUT_FILE
