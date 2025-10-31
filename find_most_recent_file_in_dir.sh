#!/bin/bash

# This script finds the most recent file in a specified directory
# searching through all files and directories recursively.

find_most_recent_file() {
    local dir="$1"
    
    if [[ ! -d "$dir" ]]; then
        echo "Error: '$dir' is not a directory."
        return 1
    fi

    # Find the most recent file in the directory and its subdirectories
    echo "Searching in directory: $dir"
    find "$dir" -type f -exec stat --format='%Y %n' {} + | sort -n | tail -n 1 | cut -d ' ' -f2-
    echo "Search completed."
}

# Check if a directory is provided as an argument
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Call the function with the provided directory
find_most_recent_file "$1"
exit 0