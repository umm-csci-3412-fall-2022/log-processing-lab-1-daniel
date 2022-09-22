#!/usr/bin/env bash

tar_dir=$1
parent_dir=$(${pwd}/log_files)

tar -zxf "${parent_dir}/${tar_dir}" | grep > failed_login_data.txt
