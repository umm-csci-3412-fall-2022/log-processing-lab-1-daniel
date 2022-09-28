#!/usr/bin/env bash

# Store directory input (where work will happen)
target_dir=$1


# Consolidate (cat) all failed_login_data.txt files and funnel usernames to temp file

# make temp file for later storing usernames
temp_file=$(mktemp)

# combine text files, awk over the rows of data, print username and send output to temp
# https://www.linuxcommands.site/linux-text-processing-commands/linux-awk-command/awk-sort-uniq/
# https://unix.stackexchange.com/questions/222709/how-to-print-quote-character-in-awk/222717#222717

cat "$target_dir"/*/failed_login_data.txt | awk '{print $4}' | sort | uniq -c | awk 'match($0, / *([0-9]+) +([a-zA-Z0-9_\-]+)/, groups) {print "data.addRow([\x27" groups[2] "\x27, " groups[1] "]);"}' > "$temp_file"

# wrap usernames with header and footer, write to new username_dist.html
./bin/wrap_contents.sh "$temp_file" html_components/username_dist "$target_dir"/username_dist.html
