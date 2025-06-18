#!/bin/bash

# Update the package list
sudo apt update -y

# Add Adoptium repository for Temurin JDK
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /etc/apt/keyrings/adoptium.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list > /dev/null

# Update the package list again
sudo apt update -y

# Install Temurin JDK 17
sudo apt install temurin-17-jdk -y

# Verify Java installation
/usr/bin/java --version

# Add Jenkins repository
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update the package list again
sudo apt-get update -y

# Install Jenkins
sudo apt-get install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins

# Check Jenkins service status
sudo systemctl status jenkins