#!/bin/bash
# This script unmounts a disk and removes its mount point.
# Usage: ./unmount-disk.sh <mount_point>
# Example: ./unmount-disk.sh /mnt/mydisk

read -p "Enter the mount point to unmount: " mount_point
if [ -z "$mount_point" ]; then
    echo "Mount point cannot be empty."
    exit 1
fi

unmount_disk() {
    local mount_point="$1"

    if [ -z "$mount_point" ]; then
        echo "Mount point cannot be empty."
        return 1
    fi

    if [ ! -d "$mount_point" ]; then
        echo "Mount point $mount_point does not exist."
        return 1
    fi

    echo "Unmounting $mount_point..."
    sudo umount "$mount_point"
    if [ $? -ne 0 ]; then
        echo "Failed to unmount $mount_point."
        return 1
    fi

    echo "Removing mount point $mount_point..."
    sudo rm -rf "$mount_point"
    if [ $? -ne 0 ]; then
        echo "Failed to remove mount point $mount_point."
        return 1
    fi

    echo "Successfully unmounted and removed $mount_point."
}

check_unmount_status() {
    local mount_point="$1"

    if mount | grep "$mount_point" > /dev/null; then
        echo "Disk is still mounted."
    else
        echo "Disk is successfully unmounted."
    fi
}

check_mount_point_removal() {
    local mount_point="$1"

    if [ -d "$mount_point" ]; then
        echo "Mount point $mount_point still exists."
    else
        echo "Mount point $mount_point successfully removed."
    fi
}

read -p "Enter the mount point to unmount: " mount_point

unmount_disk "$mount_point"

if [ $? -eq 0 ]; then
    check_unmount_status "$mount_point"
    check_mount_point_removal "$mount_point"
fi
# 