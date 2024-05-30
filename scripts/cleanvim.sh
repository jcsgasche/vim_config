#!/bin/bash

# Define the files to be deleted
files_to_delete=("$HOME/.ideavimrc" "$HOME/.vimrc" "$HOME/.config/nvim/init.vim")

# Loop through each file and delete if it exists
for file in "${files_to_delete[@]}"; do
    if [ -f "$file" ]; then
        echo "Deleting $file..."
        rm "$file"
        echo "$file deleted."
    else
        echo "$file does not exist."
    fi
done

echo "Script executed successfully."
