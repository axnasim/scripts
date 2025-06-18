#!/bin/bash

# Function to install AWS CLI on Linux
install_awscli_linux() {
    echo "Installing AWS CLI on Linux..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
}

# Function to install AWS CLI on macOS
install_awscli_macos() {
    echo "Installing AWS CLI on macOS..."
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
    rm AWSCLIV2.pkg
}

# Function to install AWS CLI on WSL (Windows Subsystem for Linux)
install_awscli_wsl() {
    echo "Installing AWS CLI on WSL..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
}

# Detect the OS and install AWS CLI
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ $(uname -r) == *microsoft* ]]; then
        install_awscli_wsl
    else
        install_awscli_linux
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_awscli_macos
else
    echo "Unsupported operating system. Please install AWS CLI manually."
    exit 1
fi

# Verify AWS CLI installation
if command -v aws &> /dev/null; then
    echo "AWS CLI installed successfully!"
    aws --version
else
    echo "AWS CLI installation failed. Please check the logs and try again."
    exit 1
fi
# Cleanup
rm -rf /tmp/awscli_install
echo "Cleanup completed."
echo "AWS CLI installation script completed."
echo "You can now use AWS CLI. Run 'aws --version' to verify the installation."
echo "For more information, visit the official AWS CLI documentation: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html"
echo "Thank you for using the AWS CLI installation script!"