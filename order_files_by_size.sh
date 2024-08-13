#!/bin/bash

# Check if the number of files to display is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <number_of_files>"
    exit 1
fi

# Get the number of files to display
N=$1

# Use ls -lahR to get file information, then process with awk and sort
ls -lahR | awk '
BEGIN { OFS="\t" }
/^-/ {
    size = $5
    gsub(/,/, ".", size)  # Replace comma with dot for decimal numbers
    if (size ~ /K$/) size = substr(size, 1, length(size)-1) * 1024
    else if (size ~ /M$/) size = substr(size, 1, length(size)-1) * 1024 * 1024
    else if (size ~ /G$/) size = substr(size, 1, length(size)-1) * 1024 * 1024 * 1024
    print size, $9, FILENAME
}
/^\..*:$/ { FILENAME = substr($0, 1, length($0)-1) }
' | sort -rn | head -n "$N" | awk '
BEGIN { OFS="\t"; print "Size", "Filename", "Path" }
{
    size = $1
    if (size >= 1024*1024*1024) 
        printf "%.2f GB\t%s\t%s\n", size/(1024*1024*1024), $2, $3
    else if (size >= 1024*1024) 
        printf "%.2f MB\t%s\t%s\n", size/(1024*1024), $2, $3
    else if (size >= 1024) 
        printf "%.2f KB\t%s\t%s\n", size/1024, $2, $3
    else 
        printf "%d B\t%s\t%s\n", size, $2, $3
}'
