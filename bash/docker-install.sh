#!/bin/bash

# Function to install Docker on Ubuntu/Debian
install_docker_debian() {
    echo "Installing Docker on Debian/Ubuntu..."
    sudo apt update -y
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update -y
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
    # Add user to docker group
    sudo usermod -aG docker $USER
    echo "User $USER added to the docker group. Please log out and log back in for the changes to take effect."
}

# Function to install Docker on CentOS/RHEL
install_docker_centos() {
    echo "Installing Docker on CentOS/RHEL..."
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
    # Add user to docker group
    sudo usermod -aG docker $USER
    echo "User $USER added to the docker group. Please log out and log back in for the changes to take effect."
}

# Function to install Docker on macOS
install_docker_macos() {
    echo "Installing Docker on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install --cask docker
    echo "Docker installed. Please open Docker.app from the Applications folder to complete the setup."
}

# Detect the OS and install Docker
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt &> /dev/null; then
        install_docker_debian
    elif command -v yum &> /dev/null; then
        install_docker_centos
    else
        echo "Unsupported Linux distribution. Please install Docker manually."
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_docker_macos
else
    echo "Unsupported operating system. Please install Docker manually."
    exit 1
fi

# Verify Docker installation
if command -v docker &> /dev/null; then
    echo "Docker installed successfully!"
    docker --version
    # Check Docker service status (Linux only)
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Checking Docker service status..."
        sudo systemctl status docker
    fi
else
    echo "Docker installation failed. Please check the logs and try again."
    exit 1
fi
# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Please start Docker and try again."
    exit 1
fi