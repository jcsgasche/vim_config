#!/bin/sh

# Script directory
script_dir=$(dirname "$0")
config_dir=$(dirname "$script_dir")/../../rc

# Function to append the vimrc and ideavimrc files to ~/.ideavimrc if not already present
append_vimrc_to_ideavimrc() {
    local target_file="$HOME/.ideavimrc"
    if [ ! -f "$target_file" ]; then
        touch "$target_file"
    fi
    if ! grep -Fq "$(cat "$config_dir/vimrc")" "$target_file"; then
        cat "$config_dir/vimrc" >> "$target_file"
    else
        echo "The content of vimrc is already in $target_file"
    fi
    if ! grep -Fq "$(cat "$config_dir/ideavimrc")" "$target_file"; then
        cat "$config_dir/ideavimrc" >> "$target_file"
    else
        echo "The content of ideavimrc is already in $target_file"
    fi
}

# Append vimrc and ideavimrc content to ~/.ideavimrc
append_vimrc_to_ideavimrc

echo "Script executed successfully."

