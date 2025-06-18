#!/bin/bash

# Script to install the Google Cloud CLI (gcloud CLI)

# Check if curl is installed
if ! command -v curl &> /dev/null; then
  echo "Error: curl is required to download the gcloud CLI."
  echo "Please install curl and then run this script again."
  exit 1
fi

# Determine the operating system
OS=$(uname -s)
ARCH=$(uname -m)

echo "Detected operating system: $OS"
echo "Detected architecture: $ARCH"

# Define the installation directory
INSTALL_DIR="$HOME/google-cloud-sdk"

# Define the download URL based on the OS and architecture
case "$OS" in
  Linux)
    DOWNLOAD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux.tar.gz"
    ;;
  Darwin) # macOS
    DOWNLOAD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin.tar.gz"
    ;;
  *)
    echo "Error: Unsupported operating system: $OS"
    exit 1
    ;;
esac

echo "Downloading gcloud CLI from: $DOWNLOAD_URL"

# Download the gcloud CLI archive
curl -L "$DOWNLOAD_URL" -o gcloud.tar.gz

if [ $? -ne 0 ]; then
  echo "Error: Failed to download gcloud CLI."
  rm -f gcloud.tar.gz
  exit 1
fi

echo "Extracting gcloud CLI to: $INSTALL_DIR"

# Create the installation directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Extract the archive
tar -xzf gcloud.tar.gz -C "$INSTALL_DIR" --strip-components=1

if [ $? -ne 0 ]; then
  echo "Error: Failed to extract gcloud CLI."
  rm -f gcloud.tar.gz
  rm -rf "$INSTALL_DIR"
  exit 1
fi

rm -f gcloud.tar.gz

echo "Running the gcloud CLI installer..."

# Run the install script
"$INSTALL_DIR/install.sh" --usage-report=no --bash-completion=yes --path-update=yes --rc-path="$HOME/.bashrc" --zsh-completion=yes --zsh-path-update=yes --zsh-rc-path="$HOME/.zshrc" -q

if [ $? -ne 0 ]; then
  echo "Error: Failed to run the gcloud CLI installer."
  exit 1
fi

echo "gcloud CLI installed successfully in: $INSTALL_DIR"
echo ""
echo "To use gcloud in your current terminal, you may need to run:"
echo "  source $HOME/.bashrc"
echo "or"
echo "  source $HOME/.zshrc"
echo ""
echo "You can now initialize the gcloud CLI by running:"
echo "  gcloud init"
echo ""
echo "For more information, visit: https://cloud.google.com/sdk/docs/install"

exit 0