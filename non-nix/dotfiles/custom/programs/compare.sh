
#!/bin/bash

# Function to normalize a string based on options
normalize_string() {
    local str="$1"
    local ignore_whitespace="$2"
    local ignore_case="$3"

    if [[ "$ignore_whitespace" == "true" ]]; then
        str=$(echo "$str" | tr -d '[:space:]')
    fi
    if [[ "$ignore_case" == "true" ]]; then
        str=$(echo "$str" | tr '[:upper:]' '[:lower:]')
    fi
    echo "$str"
}

# Function to display help message
show_help() {
    echo "Usage: $0 [-w] [-c] [-h] <string1> <string2>"
    echo "Options:"
    echo "  -w    Ignore whitespace differences"
    echo "  -c    Ignore case differences"
    echo "  -h    Show this help message"
    exit 0
}

# Parse options
IGNORE_WHITESPACE=false
IGNORE_CASE=false

while getopts "wch" opt; do
    case "$opt" in
        w) IGNORE_WHITESPACE=true ;;
        c) IGNORE_CASE=true ;;
        h) show_help ;;
        *) show_help ;;
    esac
done
shift $((OPTIND - 1))

# Ensure two arguments are provided
if [[ $# -ne 2 ]]; then
    show_help
fi

STRING1="$1"
STRING2="$2"

# Normalize strings
NORMALIZED1=$(normalize_string "$STRING1" "$IGNORE_WHITESPACE" "$IGNORE_CASE")
NORMALIZED2=$(normalize_string "$STRING2" "$IGNORE_WHITESPACE" "$IGNORE_CASE")

# Compare the normalized strings
if [[ "$NORMALIZED1" == "$NORMALIZED2" ]]; then
    echo "Strings are equal."
else
    echo "Strings are different."
fi
