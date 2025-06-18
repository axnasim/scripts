#!/bin/bash

# This script installs the Azure CLI on various operating systems.
# It detects the OS and uses the appropriate package manager to install Azure CLI.
# It also checks if Azure CLI is already installed and provides the version if it is.
# The script is designed to be run in a terminal and requires superuser privileges for installation.
# Usage: ./install_azure_cli.sh

set -e


echo "🔍 Checking if Azure CLI is installed..."

if command -v az &>/dev/null; then
  echo "✅ Azure CLI is already installed. Version: $(az version | jq -r '.["azure-cli"]' 2>/dev/null)"
  exit 0
fi

echo "📦 Azure CLI not found. Detecting OS..."

# OS Detection
OS=""
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if grep -qi "ubuntu\|debian" /etc/os-release; then
    OS="debian"
  elif grep -qi "rhel\|centos\|fedora" /etc/os-release; then
    OS="rhel"
  elif grep -qi "sles\|suse" /etc/os-release; then
    OS="suse"
  elif grep -qi "microsoft" /proc/version; then
    OS="wsl"
  else
    OS="unknown_linux"
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  OS="macos"
else
  OS="unknown"
fi

# Installer logic
install_azure_cli() {
  case "$OS" in
    debian)
      echo "🧭 Detected Debian/Ubuntu system"
      curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
      ;;
    rhel)
      echo "🧭 Detected RHEL/CentOS/Fedora system"
      sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
      sudo dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
      sudo dnf install -y azure-cli
      ;;
    suse)
      echo "🧭 Detected SUSE system"
      sudo zypper install -y azure-cli
      ;;
    macos)
      echo "🧭 Detected macOS system"
      if ! command -v brew &>/dev/null; then
        echo "❌ Homebrew is not installed. Install Homebrew first: https://brew.sh"
        exit 1
      fi
      brew install azure-cli
      ;;
    wsl)
      echo "🧭 Detected WSL (Windows Subsystem for Linux)"
      curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
      ;;
    *)
      echo "❌ Unsupported OS. Please install Azure CLI manually:"
      echo "👉 https://learn.microsoft.com/cli/azure/install-azure-cli"
      exit 1
      ;;
  esac
}

# Run installer
install_azure_cli

# Final verification
if command -v az &>/dev/null; then
  echo "✅ Azure CLI installed successfully! Version: $(az version | jq -r '.["azure-cli"]' 2>/dev/null)"
else
  echo "❌ Azure CLI installation failed."
  exit 1
fi
echo "🚀 Azure CLI is ready to use!"