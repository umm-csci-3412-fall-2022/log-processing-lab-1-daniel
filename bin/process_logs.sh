#!/usr/bin/env bash

# store input files list for naming purposes
input_files=("$@")

# make temp directory to work in
tdir=$(mktemp -d)

for log in "${input_files[@]}"
do 
    # get the base name of the client
    base_name=$(basename "${log%_secure.*}")

    # make new directory for the client in temp to extract into and work from
    mkdir "$tdir"/"$base_name"

    # extract log to named dir
    tar -xzf "$log" -C "$tdir"/"$base_name"

    # process client logs tm
    ./bin/process_client_logs.sh "$tdir"/"$base_name"

done

# now that stuff is processed, make the distributions
./bin/create_username_dist.sh "$tdir"
./bin/create_hours_dist.sh "$tdir"
./bin/create_country_dist.sh "$tdir"

# make the report
./bin/assemble_report.sh "$tdir"

# move report to top directory
mv "$tdir"/failed_login_summary.html ./failed_login_summary.html