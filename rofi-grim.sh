#!/bin/bash

# Take a screenshot using grim command and save it with a temporary file name
temp_file=$(mktemp /tmp/screenshot_XXXXXX.png)
grim $temp_file

# Use Rofi prompt to ask for a file name
file_name=$(echo -n "" | rofi -dmenu -p "Enter file name: ")

# Check if a file name was entered
if [[ -z "$file_name" ]]; then
    echo "No file name entered. Aborting."
    exit 1
fi

# Rename the temporary file to the user-provided file name
mv $temp_file "${file_name}.png"

# Notify the user that the screenshot has been saved
echo "Screenshot saved as ${file_name}.png"
