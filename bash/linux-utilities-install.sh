#!/bin/bash

# Update and upgrade Ubuntu
echo "Updating and upgrading Ubuntu..."
sudo apt update && sudo apt full-upgrade -y

# Install Java (required for Jenkins and Sonarqube)
echo "Installing Java..."
sudo apt install openjdk-17-jdk -y

# 1. Install Jenkins
echo "Installing Jenkins..."
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins

# 2. Install Docker
echo "Installing Docker..."
sudo apt install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker jenkins
sudo usermod -aG docker $USER

# 3. Install Sonarqube
echo "Installing Sonarqube..."
docker run -d --name sonarqube -p 9000:9000 sonarqube

# 4. Install Trivy
echo "Installing Trivy..."
wget https://github.com/aquasecurity/trivy/releases/download/v0.31.3/trivy_0.31.3_Linux-64bit.deb
sudo dpkg -i trivy_0.31.3_Linux-64bit.deb

# 5. Install Terraform
echo "Installing Terraform..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform -y

# 6. Install AWS CLI
echo "Installing AWS CLI..."
sudo apt install awscli -y

# 7. Install Kubectl
echo "Installing Kubectl..."
sudo snap install kubectl --classic

# 8. Install EKSctl
echo "Installing EKSctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

echo "All installations completed."