#!/bin/bash

# automate the process of creating new user accounts on a Linux server and setting up their permissions and SSH access

# Function to create a new user and set up SSH access
function createUser {   
    local username=$1
    #local password=$2
    local ssh_key=$3

    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists."
        return 1
    fi

    # Create the user
    echo "Creating user $username..."
    useradd -m -s /bin/bash "$username"
    if [ $? -ne 0 ]; then
        echo "Failed to create user $username."
        return 1
    fi
    
    # Set up SSH access
    echo "Setting up SSH access for $username..."
    mkdir -p "/home/$username/.ssh"
    echo "$ssh_key" >> "/home/$username/.ssh/authorized_keys"
    chmod 700 "/home/$username/.ssh"
    chmod 600 "/home/$username/.ssh/authorized_keys"
    chown -R "$username:$username" "/home/$username/.ssh"

    # Set up sudo permissions
    echo "Setting up sudo permissions for $username..."
    usermod -aG sudo "$username"
    if [ $? -ne 0 ]; then
        echo "Failed to set up sudo permissions for $username."
        return 1
    fi
    echo "User $username created successfully."

    # main function
    # Check if the script is run as root
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
        exit 1
    fi

    # Check if the correct number of arguments is provided
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <username> <ssh_key>"
        exit 1
    fi
}

# Main script
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <username> <password> <ssh_key>"
    exit 1
fi
username=$1
password=$2
ssh_key=$3

# Create the user
createUser "$username" "$password" "$ssh_key"

echo "User $username created successfully."
echo "SSH key added successfully."
