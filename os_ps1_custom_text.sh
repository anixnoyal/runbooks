#!/bin/bash

# Define the custom text and its color
custom_text="Jenkins-rpm"
color_code="\[\033[0;31m\]"  # Red color
reset_code="\[\033[0m\]"

# Define the line to add
line_to_add="PS1=\"\${PS1}${color_code}${custom_text} > ${reset_code}\""

# Function to update PS1 in a file
update_ps1() {
    local file="$1"
    if grep -Fxq "$line_to_add" "$file"; then
        echo "The PS1 modification is already present in $file."
    else
        echo "Appending PS1 modification to $file."
        echo "$line_to_add" >> "$file"
    fi
}

# Update /root/.bashrc for the root user
update_ps1 /root/.bashrc
