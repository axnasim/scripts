#!/bin/bash

# Function to install Terraform on Linux
install_terraform_linux() {
    echo "Installing Terraform on Linux..."
    TERRAFORM_VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    sudo unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
}

# Function to install Terraform on macOS
install_terraform_macos() {
    echo "Installing Terraform on macOS..."
    TERRAFORM_VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_darwin_amd64.zip
    sudo unzip terraform_${TERRAFORM_VERSION}_darwin_amd64.zip -d /usr/local/bin
    rm terraform_${TERRAFORM_VERSION}_darwin_amd64.zip
}

# Function to install Terraform on WSL (Windows Subsystem for Linux)
install_terraform_wsl() {
    echo "Installing Terraform on WSL..."
    TERRAFORM_VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    sudo unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
}

# Detect the OS and install Terraform
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ $(uname -r) == *microsoft* ]]; then
        install_terraform_wsl
    else
        install_terraform_linux
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_terraform_macos
else
    echo "Unsupported operating system. Please install Terraform manually."
    exit 1
fi

# Verify Terraform installation
if command -v terraform &> /dev/null; then
    echo "Terraform installed successfully!"
    terraform --version
else
    echo "Terraform installation failed. Please check the logs and try again."
    exit 1
fi
# Cleanup
rm -rf /tmp/terraform_install
echo "Cleanup completed."
echo "Terraform installation script completed."
echo "You can now use Terraform. Run 'terraform --version' to verify the installation."
echo "For more information, visit the official Terraform documentation: https://www.terraform.io/docs/index.html"
echo "Thank you for using the Terraform installation script!"
echo "If you have any issues, please report them on the GitHub repository."
echo "Have a great day!"
echo "This script is provided as-is without any warranty. Use at your own risk."
echo "For more information about the script, visit the GitHub repository."
echo "If you find this script useful, please consider giving it a star on GitHub."
echo "If you have any questions or suggestions, feel free to open an issue on GitHub."
echo "Thank you for using this script!"