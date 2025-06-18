#!/bin/bash

# Configuration
LOG_DIR="/var/log/myapp"           # Directory containing log files
BACKUP_DIR="/var/log/myapp/backup" # Directory to store compressed logs
MAX_LOG_DAYS=30                    # Maximum age of logs to keep (in days)
COMPRESSION_LEVEL=9                # Compression level (1=fast, 9=best)
DATE_FORMAT=$(date +%Y%m%d%H%M%S)  # Timestamp for backup files

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Function to compress and archive old log files
compress_logs() {
    echo "Compressing log files older than $MAX_LOG_DAYS days..."
    find "$LOG_DIR" -type f -name "*.log" -mtime +"$MAX_LOG_DAYS" | while read -r file; do
        # Compress the file
        compressed_file="$BACKUP_DIR/$(basename "$file")_$DATE_FORMAT.gz"
        gzip -"$COMPRESSION_LEVEL" -c "$file" > "$compressed_file"

        # Remove the original file after compression
        rm "$file"
        echo "Compressed and archived: $file -> $compressed_file"
    done
}

# Function to rotate current log files
rotate_logs() {
    echo "Rotating current log files..."
    find "$LOG_DIR" -type f -name "*.log" | while read -r file; do
        # Rotate the log file
        mv "$file" "$file.$DATE_FORMAT"
        touch "$file"  # Create a new empty log file
        echo "Rotated: $file -> $file.$DATE_FORMAT"
    done
}

# Main script
echo "Starting log rotation and compression process..."
compress_logs
rotate_logs
echo "Log rotation and compression process completed."
