#!/bin/bash
# Recursively searches for a given string in the contents of files in the given hierarchy


if [ $# -lt 2 ]; then
    echo "Usage: $0 <absolute_path> <string_to_search>"
    exit
fi

#OLD_PATH=`pwd`
NEW_PATH=$1
STRING="$2"

#echo $NEW_PATH

for f in `ls $NEW_PATH` ;
    do
        if [[ -d "$NEW_PATH/$f" ]] 
        then
            $0 $NEW_PATH/$f "$STRING"
        else
            RES=`cat "$NEW_PATH/$f" 2> /dev/null | grep "$STRING" | wc -m`
            if [ $RES -gt 0 ]
            then
                echo "$NEW_PATH/$f"
            fi
        fi
    done
