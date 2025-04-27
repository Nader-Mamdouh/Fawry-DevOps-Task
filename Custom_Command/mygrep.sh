#!/bin/bash

# mygrep.sh

# Function to show usage
show_help() {
    echo "Usage: ./mygrep.sh [options] <search_string> <file>"
    echo "Options:"
    echo "  -n    Show line numbers"
    echo "  -v    Invert match (show non-matching lines)"
    echo "  --help Show this help message"
    exit 1
}

# Check if --help is passed
if [[ "$1" == "--help" ]]; then
    show_help
fi

# Initialize options
show_line_number=false
invert_match=false

# Handle options
while [[ "$1" == -* ]]; do
    case "$1" in
        -n) show_line_number=true ;;
        -v) invert_match=true ;;
        -vn|-nv) show_line_number=true; invert_match=true ;;
        --help) show_help ;;
        *) echo "Invalid option: $1"; show_help ;;
    esac
    shift # shift $1 arg to next the next one and $2 arg to tnext one
done

# Now, $1 is the search string and $2 is the filename
search_string="$1"
search_file="$2"

# Validate arguments
if [[ -z "$search_string" || -z "$search_file" ]]; then
    echo "Error: Missing search string or filename."
    show_help
fi

if [[ ! -f "$search_file" ]]; then
    echo "Error: File '$file' not found."
    exit 1
fi

# Perform search
line_number=0
while IFS= read -r line; do
    ((line_number++))
    # Case-insensitive match
    if [[ "$line" =~ "$search_string" ]]; then    
    	match=true
    else
        match=false
    fi

    if { $match && ! $invert_match; } || { ! $match && $invert_match; }; then
        if $show_line_number; then
            echo "${line_number}:$line"
        else
            echo "$line"
        fi
    fi
done < "$search_file"
