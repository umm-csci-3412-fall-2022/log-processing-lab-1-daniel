#!/usr/bin/env bash

# the directory where them magic happens
target_dir=$1

# make a temp file to work in
temp_file=$(mktemp)

# pull times of failed logins and add in rows to temp file
cat "$target_dir"/*/failed_login_data.txt | awk '{print $3}' | sort | uniq -c | awk 'match($0, / *([0-9]+) +([0-9]{2})/, groups) {print "data.addRow([\x27" groups[2] "\x27, " groups[1] "]);"}' > "$temp_file"

# wrap output of previous cat with header/footer and write to hours_dist.html
./bin/wrap_contents.sh "$temp_file" html_components/hours_dist "$target_dir"/hours_dist.html