#!/bin/bash

# Directory containing the dotfiles
DOTFILES_DIR="../dotfiles"

# List of dotfiles to install
DOTFILES=(
    ".bashrc"
    # Add other dotfiles 
)

# Backup existing dotfiles and install new ones
for file in "${DOTFILES[@]}"; do
    if [ -f ~/$file ]; then
        echo "Backing up existing $file to $file.bak"
        mv ~/$file ~/$file.bak
    fi
    echo "Installing $file"
    cp $DOTFILES_DIR/$file ~/$file
done

echo "Dotfiles installation complete."