#!/bin/bash
# This script shasums all the files in a specified directory and returns a success if 
# any of the shasums match the provided checksum.

# Usage: ./check_shasum.sh <directory> <checksum>
check_shasum() {
    local dir="$1"
    local checksum="$2"

    if [[ ! -d "$dir" ]]; then
        echo "Error: '$dir' is not a directory."
        return 1
    fi

    if [[ -z "$checksum" ]]; then
        echo "Error: No checksum provided."
        return 1
    fi

    # Find all files in the directory and check their shasum
    echo "Checking files in directory: $dir"
    local i=0
    find "$dir" -type f | while read -r file; do
        i=$((i + 1))
        local total_files
        total_files=$(find "$dir" -type f | wc -l)
        echo "Processing file $i/$total_files: $file"
        file_checksum=$(sha256sum "$file" | awk '{print $1}')
        if [[ "$file_checksum" == "$checksum" ]]; then
            echo "Match found: $file"
            return 0
        else
            echo "No match for $file: $file_checksum"
        fi
    done

    echo "No matching shasum found."
    return 1
}
# Check if the correct number of arguments is provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <directory> <checksum>"
    exit 1
fi  
# Call the function with the provided arguments
check_shasum "$1" "$2"
exit 0