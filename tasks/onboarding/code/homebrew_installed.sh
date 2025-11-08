#!/bin/bash

# This script checks if Homebrew is installed and, if not, installs it.

# Check if Homebrew is installed
if command -v brew >/dev/null 2>&1; then
    echo "Homebrew is already installed."
else
    echo "Homebrew not found. Installing Homebrew..."

    # Use the official Homebrew installation command for macOS
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH if it was just installed (for non-default shells or new installs)
    if [[ -d /opt/homebrew/bin ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d /usr/local/bin ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    echo "Homebrew installation complete."
fi
