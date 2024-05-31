#!/bin/zsh

# Check if vim and nvim are installed
vim_installed=$(command -v vim)
nvim_installed=$(command -v nvim)

# Script directory
script_dir=$(dirname "$0")
config_dir=$(dirname "$script_dir")/../../rc

# Function to install nvim and set the alias
install_nvim() {
    echo "Installing nvim..."
    sudo dnf update -y
    sudo dnf install -y neovim
    add_nvim_alias
}

# Function to add the "v" alias for nvim to the appropriate configuration file
add_nvim_alias() {
    if ! grep -Fq "alias v='nvim'" ~/.zshrc; then
        echo "alias v='nvim'" >> ~/.zshrc
    else
        echo "Alias 'v' is already set in ~/.zshrc"
    fi
}

# Function to append the vimrc file to a target file if not already present
append_vimrc_to_file() {
    local target_file="$1"
    local source_file="$2"
    if [ ! -f "$target_file" ]; then
        touch "$target_file"
    fi
    if ! grep -Fq "$(cat "$source_file")" "$target_file"; then
        cat "$source_file" >> "$target_file"
    else
        echo "The content of $source_file is already in $target_file"
    fi
}

# Check if nvim is installed and handle alias and configuration
if [ -z "$nvim_installed" ]; then
    install_nvim
fi

# Ensure the alias is set if nvim is installed
if [ -n "$nvim_installed" ]; then
    add_nvim_alias
fi

# Check if init.vim exists and append vimrc content if not already present
if [ -d ~/.config/nvim ]; then
    append_vimrc_to_file ~/.config/nvim/init.vim "$config_dir/vimrc"
else
    mkdir -p ~/.config/nvim
    append_vimrc_to_file ~/.config/nvim/init.vim "$config_dir/vimrc"
fi

# Check and handle vim if installed
if [ -n "$vim_installed" ]; then
    vimrc_file=~/.vimrc
    if [ ! -f "$vimrc_file" ]; then
        touch "$vimrc_file"
    fi
    append_vimrc_to_file "$vimrc_file" "$config_dir/vimrc"
fi

echo "Script executed successfully."

