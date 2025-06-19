#!/bin/bash

# Prompt for new assignment name
read -p "Enter the new assignment name: " new_assignment

# Find the correct app directory (assumes only one submission_reminder_* dir exists in current folder)
dir_name=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)

if [[ -z "$dir_name" ]]; then
    echo "Error: Could not find your submission_reminder directory."
    exit 1
fi

CONFIG_FILE="$dir_name/config/config.env"

# Check if config.env exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: config.env not found in $dir_name/config/"
    exit 1
fi

# Update the ASSIGNMENT value (macOS compatible sed)
sed -i '' "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$CONFIG_FILE"

echo "Assignment updated to '$new_assignment' in $CONFIG_FILE"

# Run startup.sh
if [[ -f "$dir_name/startup.sh" ]]; then
    echo "Running startup.sh to check for pending submissions..."
    (cd "$dir_name" && ./startup.sh)
else
    echo " Error: startup.sh not found in $dir_name"
    exit 1
fi

