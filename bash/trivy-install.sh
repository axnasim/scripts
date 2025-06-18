#!/bin/bash

# Function to install Trivy on Linux
install_trivy_linux() {
    echo "Installing Trivy on Linux..."
    TRIVY_VERSION=$(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
    sudo apt-get update -y
    sudo apt-get install -y wget apt-transport-https gnupg lsb-release
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
    echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
    sudo apt-get update -y
    sudo apt-get install -y trivy
}

# Function to install Trivy on macOS
install_trivy_macos() {
    echo "Installing Trivy on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install aquasecurity/trivy/trivy
}

# Function to install Trivy on WSL (Windows Subsystem for Linux)
install_trivy_wsl() {
    echo "Installing Trivy on WSL..."
    TRIVY_VERSION=$(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
    wget https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz
    tar -xzf trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz
    sudo mv trivy /usr/local/bin/
    rm trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz
}

# Detect the OS and install Trivy
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ $(uname -r) == *microsoft* ]]; then
        install_trivy_wsl
    else
        install_trivy_linux
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_trivy_macos
else
    echo "Unsupported operating system. Please install Trivy manually."
    exit 1
fi

# Verify Trivy installation
if command -v trivy &> /dev/null; then
    echo "Trivy installed successfully!"
    trivy --version
else
    echo "Trivy installation failed. Please check the logs and try again."
    exit 1
fi
# # Check for updates
# trivy --update
# # Check for vulnerabilities
# trivy image --vuln-type os,library --severity HIGH,CRITICAL --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for misconfigurations
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for secrets
# trivy secret --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for compliance
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for license compliance
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for infrastructure as code
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for container image scanning
# trivy image --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for file system scanning
# trivy fs --ignore-unfixed --exit-code 1 --timeout 10m /path/to/directory
# # Check for network scanning
# trivy network --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for runtime security
# trivy runtime --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for compliance as code
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security as code
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security policies
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security best practices
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security hardening
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security benchmarks
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security policies as code
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security compliance
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security audits
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security assessments
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security reviews
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security testing
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security monitoring
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security logging
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security alerting
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security incident response
# trivy config --ignore-unfixed --exit-code 1 --timeout 10m docker.io/library/ubuntu:latest
# # Check for security incident management        