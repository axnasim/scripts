#!/bin/bash

# This script will check the CPU, memory, and disk usage of the system and send an alert if any of them exceed a specified threshold.
# Using functions to organize the code and make it more readable.

# configuration
output_file="resource_usage_report.txt"
THRESHOLD_CPU=80
THRESHOLD_MEMORY=80
THRESHOLD_DISK=80
ALERT_EMAIL="n45333m@gmail.com"
ALERT_SUBJECT="System Alert: High Resource Usage"
ALERT_MESSAGE="The following resource usage has exceeded the threshold:\n\n"

# Function to check CPU usage
function check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$CPU_USAGE > $THRESHOLD_CPU" | bc -l) )); then
        ALERT_MESSAGE+="CPU usage: $CPU_USAGE%\n"
    fi
}
# Function to check memory usage
function check_memory() {
    MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$MEMORY_USAGE > $THRESHOLD_MEMORY" | bc -l) )); then
        ALERT_MESSAGE+="Memory usage: $MEMORY_USAGE%\n"
    fi
}
# Function to check disk usage
function check_disk() {
    DISK_USAGE=$(df -h | grep '^/dev/' | awk '{print $5}' | sed 's/%//g' | sort -n | tail -1)
    if (( DISK_USAGE > THRESHOLD_DISK )); then
        ALERT_MESSAGE+="Disk usage: $DISK_USAGE%\n"
    fi
}

# Date and time
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Check CPU, memory, and disk usage
check_cpu
check_memory
check_disk
# If any of the checks exceeded the threshold, send an alert
if [[ $ALERT_MESSAGE != "The following resource usage has exceeded the threshold:\n\n" ]]; then
    ALERT_MESSAGE="[$DATE]\n$ALERT_MESSAGE"
    echo -e "$ALERT_MESSAGE" | mail -s "$ALERT_SUBJECT" "$ALERT_EMAIL"
fi

# Create a table formatted report
output="
| Resource | Usage (%) | Threshold (%) | Status |
|------------------------------------------------
Resource Usage Report - $DATE
-------------------------------------------------
CPU Usage:          $CPU_USAGE% 
Memory Usage:       $MEMORY_USAGE%
Disk Usage:         $DISK_USAGE%
------------------------------------------------"

# Write the report to a file
echo "$output" > $output_file
# Print the report to the console
echo "$output"
done

# Check if threshold is exceeded and send alert
if (( $(echo "$CPU_USAGE > $THRESHOLD_CPU" | bc -l) )); then
    echo "ALERT: CPU usage is above threshold!"
    subject="ALERT: HIGH CPU USAGE"
    message="CPU usage is at $CPU_USAGE%, which is exceeds the threshold of $THRESHOLD_CPU%."
    echo -e "$message" | mail -s "$subject" "$ALERT_EMAIL"
fi

if (( $(echo "$MEMORY_USAGE > $THRESHOLD_MEMORY" | bc -l) )); then
    echo "ALERT: Memory usage is above threshold!"
    subject="ALERT: HIGH MEMORY USAGE"
    message="Memory usage is at $MEMORY_USAGE%, which exceeds the threshold of $THRESHOLD_MEMORY%."
    echo -e "$message" | mail -s "$subject" "$ALERT_EMAIL"
fi

if (( DISK_USAGE > THRESHOLD_DISK )); then
    echo "ALERT: Disk usage is above threshold!"
    subject="ALERT: HIGH DISK USAGE"
    message="Disk usage is at $DISK_USAGE%, which exceeds the threshold of $THRESHOLD_DISK%."
    echo -e "$message" | mail -s "$subject" "$ALERT_EMAIL"
fi

# Print the report to the console
echo "Resource Usage Report - $DATE"
echo "---------------------------------"
echo "| Resource | Usage (%) | Threshold (%) | Status |"
echo "|----------|-----------|----------------|--------|"
echo "CPU Usage: $CPU_USAGE%"
echo "Memory Usage: $MEMORY_USAGE%" 
echo "Disk Usage: $DISK_USAGE%"
echo "---------------------------------"
done

echo "Resource usage report saved to $output_file"