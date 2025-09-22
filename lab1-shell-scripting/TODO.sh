#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory_path> <string>"
    exit 1
fi

DIR="$1"
PATTERN="$2"

if [ ! -d "$DIR" ]; then
    echo "Error: $DIR is not a directory"
    exit 1
fi

FILES=$(find "$DIR" -type f -name "${PATTERN}*" -printf '%A@ %p\n' 2>/dev/null)

if [ -z "$FILES" ]; then
    echo "No files starting with \"$PATTERN\" found in directory $DIR."
    exit 0
fi

echo "$FILES" | sort -nr | awk '{ $1=""; sub(/^ /,""); print }'
