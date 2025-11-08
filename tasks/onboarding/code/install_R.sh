#!/bin/bash

set -e # Exit on any error
set -u # Treat unset variables as errors

# Read argument: R version
if [ $# -eq 0 ]; then
    echo "Usage: $0 <R_VERSION>"
    exit 1
fi
R_VERSION="$1"

OS="$(uname)"
echo "Operating system detected: $OS"

if [[ "$OS" == "Darwin" ]]; then
    ARCH=$(uname -m)
    if [[ "$ARCH" == "arm64" ]]; then
        CRAN_R_URL="https://cran.r-project.org/bin/macosx/big-sur-arm64/base/R-$R_VERSION-arm64.pkg"
    elif [[ "$ARCH" == "x86_64" ]]; then
        CRAN_R_URL="https://cran.r-project.org/bin/macosx/big-sur-x86_64/base/R-$R_VERSION-x86_64.pkg"
    else
        echo "Unsupported macOS architecture: $ARCH"
        exit 1
    fi

    # Check if R is already installed
    if command -v R >/dev/null 2>&1; then
        echo "R is already installed at $(which R). Version:"
        R --version

        read -p "Preferred version is $R_VERSION. Overwrite existing R installation? [confirmed/n] " answer
        answer="${answer:-n}"  # default to 'n' if empty
        if [[ "$answer" != "confirmed" ]]; then
            echo "Skipping installation."
            exit 0
        fi
    fi

    echo "Downloading R from $CRAN_R_URL"
    curl -O "$CRAN_R_URL"
    sudo installer -pkg "$(basename "$CRAN_R_URL")" -target /
    echo "R installed successfully on macOS."

elif [[ "$OS" == "Linux" ]]; then
    # Check if R is already installed
    if command -v R >/dev/null 2>&1; then
        echo "R is already installed at $(which R). Version:"
        R --version

        read -p "Preferred version is $R_VERSION. Overwrite existing R installation? [confirmed/n] " answer
        answer="${answer:-n}"  # default to 'n' if empty
        if [[ "$answer" != "confirmed" ]]; then
            echo "Skipping installation."
            exit 0
        fi
    fi

    echo "Installing R on Debian/Ubuntu Linux..."

    # Install prerequisites
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends software-properties-common dirmngr gnupg apt-transport-https ca-certificates

    # Add CRAN GPG key and repo
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/cran.gpg > /dev/null

    # Get Ubuntu codename
    CODENAME=$(lsb_release -cs)
    echo "Ubuntu codename: $CODENAME"

    # Add CRAN to sources.list
    echo "deb [signed-by=/etc/apt/keyrings/cran.gpg] https://cloud.r-project.org/bin/linux/ubuntu $CODENAME-cran40/" | sudo tee /etc/apt/sources.list.d/cran.list

    sudo apt-get update
    sudo apt-get install -y --no-install-recommends r-base

    echo "R installed successfully on Linux."

else
    echo "Unsupported operating system: $OS"
    exit 1
fi

# Show R version
echo "Installed R version:"
R --version

# Write stamp file
STAMP_FILE="../output/R_installed.txt"

echo "R version $R_VERSION installed on $(date)" > "$STAMP_FILE"
echo "Stamp file created at $STAMP_FILE"
