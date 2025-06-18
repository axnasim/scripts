#!/bin/bash

set -e

echo "🔍 Checking if AWS CLI is installed..."

if command -v aws &>/dev/null; then
  echo "✅ AWS CLI is already installed. Version: $(aws --version 2>&1 | grep -oP 'aws-cli/\K[^ ]+')"
  exit 0
fi

echo "📦 AWS CLI not found. Detecting OS..."

# OS Detection
OS=""
DISTRO=""

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  OS="linux"

  # Attempt to determine the specific distribution
  if command -v apt-get &>/dev/null; then
    DISTRO="debian"  # Debian, Ubuntu, Mint, etc.
  elif command -v yum &>/dev/null; then
    DISTRO="rhel"    # Red Hat, CentOS, Fedora, Amazon Linux
  elif command -v dnf &>/dev/null; then
    DISTRO="fedora"  # Modern Fedora
  elif command -v zypper &>/dev/null; then
    DISTRO="suse"    # openSUSE, SLES
  elif grep -qi "microsoft" /proc/version; then
    DISTRO="wsl"     # Windows Subsystem for Linux
  else
    DISTRO="unknown" # Generic Linux
  fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
  OS="macos"
  DISTRO="macos"
else
  OS="unknown"
  DISTRO="unknown"
fi

# Installer logic
install_aws_cli() {
  case "$OS" in
    linux)
      echo "🧭 Detected Linux system"

      # Dependency Check and Installation
      INSTALL_CURL=""
      INSTALL_UNZIP=""

      case "$DISTRO" in
        debian|wsl)
          INSTALL_CURL="sudo apt-get update && sudo apt-get install -y curl"
          INSTALL_UNZIP="sudo apt-get install -y unzip"
          ;;
        rhel)
          INSTALL_CURL="sudo yum install -y curl"
          INSTALL_UNZIP="sudo yum install -y unzip"
          ;;
        fedora)
          INSTALL_CURL="sudo dnf install -y curl"
          INSTALL_UNZIP="sudo dnf install -y unzip"
          ;;
        suse)
          INSTALL_CURL="sudo zypper install -y curl"
          INSTALL_UNZIP="sudo zypper install -y unzip"
          ;;
        *)
          echo "⚠️  Unknown Linux distribution.  Please install curl and unzip manually."
          INSTALL_CURL=""
          INSTALL_UNZIP=""
          ;;
      esac

      # Install curl if missing
      if ! command -v curl &>/dev/null; then
        echo "❌ curl is required."
        if [ -n "$INSTALL_CURL" ]; then
          echo "   Installing with: $INSTALL_CURL"
          eval "$INSTALL_CURL"  # Execute the installation command
          if ! command -v curl &>/dev/null; then
            echo "❌ curl installation failed."
            exit 1
          fi
        else
          echo "   Please install curl manually."
          exit 1
        fi
      fi

      # Install unzip if missing
      if ! command -v unzip &>/dev/null; then
        echo "❌ unzip is required."
        if [ -n "$INSTALL_UNZIP" ]; then
          echo "   Installing with: $INSTALL_UNZIP"
          eval "$INSTALL_UNZIP"  # Execute the installation command
          if ! command -v unzip &>/dev/null; then
            echo "❌ unzip installation failed."
            exit 1
          fi
        else
          echo "   Please install unzip manually."
          exit 1
        fi
      fi

      # Download AWS CLI
      curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

      # Unzip AWS CLI
      unzip awscliv2.zip

      # Install AWS CLI (using a standard location)
      sudo ./aws/install --update --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli

      # Clean up
      rm awscliv2.zip
      sudo rm -rf aws

      ;;
    macos)
      echo "🧭 Detected macOS system"
      if ! command -v brew &>/dev/null; then
        echo "❌ Homebrew is not installed. Install Homebrew first: https://brew.sh"
        exit 1
      fi
      brew install awscli
      ;;
    *)
      echo "❌ Unsupported OS. Please install AWS CLI manually:"
      echo "👉 https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
      exit 1
      ;;
  esac
}

# Run installer
install_aws_cli

# Final verification
if command -v aws &>/dev/null; then
  echo "✅ AWS CLI installed successfully! Version: $(aws --version 2>&1 | grep -oP 'aws-cli/\K[^ ]+')"
else
  echo "❌ AWS CLI installation failed."
  exit 1
fi

echo "ℹ️  Detected OS: $OS"
echo "ℹ️  Detected Distribution: $DISTRO"