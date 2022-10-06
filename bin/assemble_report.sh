#!/usr/bin/env bash

# where the magic happens (input directory where report will be assembled)
target_dir=$1

# temp working file
temp_file=$(mktemp)

# cat the distribution htmls and write to temp
cat "$target_dir"/*.html > "$temp_file"

# wrap temp_file contents and write to new summary html
./bin/wrap_contents.sh "$temp_file" ./html_components/summary_plots "$target_dir"/failed_login_summary.html