#!/usr/bin/env bash

target_dir=$1

temp_file=$(mktemp)

# take IPs from column in failed_login_data files and put in temp_file
cat "$target_dir"/*/failed_login_data.txt | awk '{print $5}' | sort > "$temp_file"

# join ips with country comparison, count country occurence, and wrap with country_dist footer and header
# initially tried to direct output back to temp file, this link told why I couldn't, and suggested sponge: https://stackoverflow.com/questions/6696842/how-can-i-use-a-file-in-a-command-and-redirect-output-to-the-same-file-without-t
# comment said to use with caution since sponge is destructive, I wouldn't use it if I wasn't using vc (git) and only running this through the bats tests
# could've just made another temp file but didn't want to
join "$temp_file" etc/country_IP_map.txt | awk '{print $2}' | sort | uniq -c | awk 'match($0, / *([0-9]+) *([A-Z]{2})/, groups) {print "data.addRow([\x27" groups[2] "\x27, " groups[1] "]);"}' | sponge $temp_file

./bin/wrap_contents.sh "$temp_file" ./html_components/country_dist "$target_dir"/country_dist.html

# delete temp
rm $temp_file