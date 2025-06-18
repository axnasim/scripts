#!/bin/bash

# Function to install gcloud on Linux
install_gcloud_linux() {
    echo "Installing gcloud on Linux..."
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    sudo apt-get update -y
    sudo apt-get install -y google-cloud-sdk
}

# Function to install gcloud on macOS
install_gcloud_macos() {
    echo "Installing gcloud on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew update && brew install --cask google-cloud-sdk
}

# Function to install gcloud on WSL (Windows Subsystem for Linux)
install_gcloud_wsl() {
    echo "Installing gcloud on WSL..."
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    sudo apt-get update -y
    sudo apt-get install -y google-cloud-sdk
}

# Detect the OS and install gcloud
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ $(uname -r) == *microsoft* ]]; then
        install_gcloud_wsl
    else
        install_gcloud_linux
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_gcloud_macos
else
    echo "Unsupported operating system. Please install gcloud manually."
    exit 1
fi

# Verify gcloud installation
if command -v gcloud &> /dev/null; then
    echo "gcloud installed successfully!"
    gcloud --version
else
    echo "gcloud installation failed. Please check the logs and try again."
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
