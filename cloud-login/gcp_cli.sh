#!/bin/bash 

set -e

echo "Checking if gcloud CLI is installed..."

if command -v gcloud &>/dev/null; then
  echo " gcloud CLI is already installed. Version: $(gcloud version 2>&1 | grep Google Cloud SDK | awk '{print $4}')"
  exit 0
fi

echo " gcloud CLI not found. Detecting OS..."

# OS Detection
OS=""
DISTRO=""

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  OS="linux"

  # Check for WSL
  if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
    DISTRO="wsl"
  # Determine specific distribution
  elif command -v apt-get &>/dev/null; then
    DISTRO="debian"  # Debian, Ubuntu, Mint, etc.
  elif command -v yum &>/dev/null; then
    DISTRO="rhel"    # Red Hat, CentOS, Fedora, Amazon Linux
  elif command -v dnf &>/dev/null; then
    DISTRO="fedora"  # Modern Fedora
  elif command -v zypper &>/dev/null; then
    DISTRO="suse"    # openSUSE, SLES
  else
    DISTRO="unknown" # Generic Linux
  fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
  OS="macos"
  DISTRO="macos"
elif [[ "$OSTYPE" == "msys"* ]]; then
  OS="windows" # Git Bash on Windows
  DISTRO="windows"
else
  OS="unknown"
  DISTRO="unknown"
fi

echo "  Detected OS: $OS"
echo "  Detected Distribution: $DISTRO"

# Installer logic
install_gcloud_cli() {
  case "$OS" in
    linux)
      echo " Detected Linux system"

      # Dependency Check and Installation Instructions
      INSTALL_CURL=""
      INSTALL_UNZIP=""
      INSTALL_APT_TRANSPORT_HTTPS="" # For Debian-based systems

      case "$DISTRO" in
        debian|wsl)
          INSTALL_CURL="sudo apt-get update && sudo apt-get install -y curl"
          INSTALL_UNZIP="sudo apt-get install -y unzip"
          INSTALL_APT_TRANSPORT_HTTPS="sudo apt-get install -y apt-transport-https ca-certificates"
          ;;
        rhel|fedora)
          INSTALL_CURL="sudo yum install -y curl"
          INSTALL_UNZIP="sudo yum install -y unzip"
          ;;
        suse)
          INSTALL_CURL="sudo zypper install -y curl"
          INSTALL_UNZIP="sudo zypper install -y unzip"
          ;;
        *)
          echo "  Unknown Linux distribution. Please install curl and unzip manually."
          INSTALL_CURL=""
          INSTALL_UNZIP=""
          ;;
      esac

      # Install curl if missing
      if ! command -v curl &>/dev/null; then
        echo " curl is required."
        if [ -n "$INSTALL_CURL" ]; then
          echo "   Installing with: $INSTALL_CURL"
          eval "$INSTALL_CURL"
          if ! command -v curl &>/dev/null; then
            echo " curl installation failed."
            exit 1
          fi
        else
          echo "   Please install curl manually."
          exit 1
        fi
      fi

      # Install unzip if missing
      if ! command -v unzip &>/dev/null; then
        echo " unzip is required."
        if [ -n "$INSTALL_UNZIP" ]; then
          echo "   Installing with: $INSTALL_UNZIP"
          eval "$INSTALL_UNZIP"
          if ! command -v unzip &>/dev/null; then
            echo " unzip installation failed."
            exit 1
          fi
        else
          echo "   Please install unzip manually."
          exit 1
        fi
      fi

      # Install apt-transport-https if missing (Debian/Ubuntu/WSL)
      if [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "wsl" ]; then
        if ! dpkg -s apt-transport-https ca-certificates >/dev/null 2>&1; then
          echo " apt-transport-https and ca-certificates are required."
          if [ -n "$INSTALL_APT_TRANSPORT_HTTPS" ]; then
            echo "   Installing with: $INSTALL_APT_TRANSPORT_HTTPS"
            eval "$INSTALL_APT_TRANSPORT_HTTPS"
            if ! dpkg -s apt-transport-https ca-certificates >/dev/null 2>&1; then
              echo " apt-transport-https and ca-certificates installation failed."
              exit 1
            fi
          else
            echo "   Please install apt-transport-https and ca-certificates manually."
            exit 1
          fi
        fi
      fi

      # Download and install gcloud CLI
      echo "⬇ Downloading and installing gcloud CLI..."
      curl -sSL https://sdk.cloud.google.com | bash > /tmp/gcloud_install.log 2>&1
      
      # Add gcloud to PATH
      if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then
        source "$HOME/google-cloud-sdk/path.bash.inc"
      fi
      
      # Clean up
      rm /tmp/gcloud_install.log

      ;;
    macos)
      echo " Detected macOS system"
      if ! command -v brew &>/dev/null; then
        echo " Homebrew is not installed. Install Homebrew first: https://brew.sh"
        exit 1
      fi
      brew install google-cloud-sdk
      ;;
    windows)
      echo " Detected Windows system (using Git Bash)"
      echo "  Automatic installation is not fully supported in this environment."
      echo "👉 Please download and install gcloud CLI manually from: https://cloud.google.com/sdk/docs/install"
      exit 1
      ;;
    *)
      echo " Unsupported OS. Please install gcloud CLI manually:"
      echo "👉 https://cloud.google.com/sdk/docs/install"
      exit 1
      ;;
  esac
}

# Run installer
install_gcloud_cli

# Final verification
if command -v gcloud &>/dev/null; then
  echo " gcloud CLI installed successfully! Version: $(gcloud version 2>&1 | grep Google Cloud SDK | awk '{print $4}')"
  echo " You may need to restart your terminal or run:"
  echo "   source ~/.bashrc  # or ~/.zshrc depending on your shell"
else
  echo " gcloud CLI installation failed."
  exit 1
fi