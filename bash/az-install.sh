#!/bin/bash

# Function to install Azure CLI on Linux
install_azurecli_linux() {
    echo "Installing Azure CLI on Linux..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

# Function to install Azure CLI on macOS
install_azurecli_macos() {
    echo "Installing Azure CLI on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew update && brew install azure-cli
}

# Function to install Azure CLI on WSL (Windows Subsystem for Linux)
install_azurecli_wsl() {
    echo "Installing Azure CLI on WSL..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

# Detect the OS and install Azure CLI
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ $(uname -r) == *microsoft* ]]; then
        install_azurecli_wsl
    else
        install_azurecli_linux
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_azurecli_macos
else
    echo "Unsupported operating system. Please install Azure CLI manually."
    exit 1
fi

# Verify Azure CLI installation
if command -v az &> /dev/null; then
    echo "Azure CLI installed successfully!"
    az --version
else
    echo "Azure CLI installation failed. Please check the logs and try again."
    exit 1
fi
# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Please install Docker first."
    exit 1
fi
# Check if Docker is running
if ! systemctl is-active --quiet docker; then
    echo "Docker is not running. Starting Docker..."
    sudo systemctl start docker
fi