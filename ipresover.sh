#!/bin/bash

# Custom banner
banner_width=49  # Adjust this value as needed to center the text
banner_text="By Raj Qureshi"
echo  "_ ___     ____ ____ ____ ____ _    _  _ ____ ____ "
echo  "| |__]    |__/ |___ [__  |  | |    |  | |___ |__/ "
echo  "| |       |  \ |___ ___] |__| |___  \/  |___ |  \ "
printf "%${padding}s%s%${padding}s\n\n" "$banner_text" " "

# Function to resolve IPv4 address from a target name
resolve_ipv4() {
    local target="$1"
    local ipv4_address
    ipv4_address=$(getent ahosts "$target" | awk '$1 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {print $1}' | head -n 1)
    if [ -n "$ipv4_address" ]; then
        echo "$target $ipv4_address"
    fi
}

# Function to print help message
print_help() {
    echo "Usage: $0 [-l <list_file> | -u <target_name>] [-o <output_file>] [-h]"
    echo "Options:"
    echo "  -l, --list        Provide a list of target names (one per line) in a file"
    echo "  -u, --url         Provide a single target name as an argument"
    echo "  -o, --output      Specify the output file (default: stdout)"
    echo "  -h, --help        Display this help message"
    exit 0
}

# Default values
input_file=""
target_name=""
output_file="/dev/stdout"

# Parse command line arguments
while [ $# -gt 0 ]; do
    case "$1" in
        -l|--list)
            shift
            input_file="$1"
            shift
            ;;
        -u|--url)
            shift
            target_name="$1"
            shift
            ;;
        -o|--output)
            shift
            output_file="$1"
            shift
            ;;
        -h|--help)
            print_help
            ;;
        *)
            echo "Unknown option: $1"
            print_help
            ;;
    esac
done

# Output headers for "URLs" and "IPs" columns
echo "URLs IPs" > "$output_file"

# Process the targets based on the input method
if [ -n "$input_file" ]; then
    while read -r target; do
        result=$(resolve_ipv4 "$target")
        if [ -n "$result" ]; then
            echo "$result" >> "$output_file"
        fi
    done < "$input_file"
elif [ -n "$target_name" ]; then
    result=$(resolve_ipv4 "$target_name")
    if [ -n "$result" ]; then
        echo "$result" >> "$output_file"
    fi
else
    echo "Please provide either a list of target names or a single target name."
    print_help
fi

