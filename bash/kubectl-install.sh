#!/bin/bash

# Function to install kubectl on Linux
install_kubectl_linux() {
    echo "Installing kubectl on Linux..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/bin/kubectl
    rm kubectl
}

# Function to install kubectl on macOS
install_kubectl_macos() {
    echo "Installing kubectl on macOS..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
    sudo install -o root -g wheel -m 0755 kubectl /usr/bin/kubectl
    rm kubectl
}

# Function to install kubectl on WSL (Windows Subsystem for Linux)
install_kubectl_wsl() {
    echo "Installing kubectl on WSL..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/bin/kubectl
    rm kubectl
}

# Detect the OS and install kubectl
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ $(uname -r) == *microsoft* ]]; then
        install_kubectl_wsl
    else
        install_kubectl_linux
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_kubectl_macos
else
    echo "Unsupported operating system. Please install kubectl manually."
    exit 1
fi

# Verify kubectl installation
if command -v kubectl &> /dev/null; then
    echo "kubectl installed successfully!"
    kubectl version --client --short
else
    echo "kubectl installation failed. Please check the logs and try again."
    exit 1
fi
# Cleanup
rm -rf /tmp/kubectl_install
echo "Cleanup completed."
echo "kubectl installation script completed."
echo "You can now use kubectl. Run 'kubectl version --client --short' to verify the installation."
echo "For more information, visit the official kubectl documentation: https://kubernetes.io/docs/reference/kubectl/overview/"
echo "Thank you for using the kubectl installation script!"