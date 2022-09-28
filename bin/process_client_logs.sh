#!/usr/bin/env bash

# Store input directory
target_dir=$1

# cat the failed login attempt lines from each file in the target dir and write to new file in same dir
cat "${target_dir}"/var/log/* | awk 'match($0, /([a-zA-Z]+) *([0-9]{1,2}) *([0-9]{2}):[0-9]{2}:[0-9]{2} [a-zA-Z_0-9\-]+ sshd\[[0-9]+]: Failed password for (invalid user )?([a-zA-Z0-9_\-]+) from ([0-9.]+) port [0-9]+ ssh2/, groups) {print groups[1] " " groups[2] " " groups[3] " " groups[5] " " groups[6]}' > "$target_dir"/failed_login_data.txt
