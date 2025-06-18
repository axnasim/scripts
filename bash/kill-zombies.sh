#!bin/bash

# This script is used to kill all zombie processes on the system.
kill_zombies() {
    # Find all zombie processes
    zombies=$(ps aux | awk '{ if ($8 == "Z") print $2 }')
    # zombie_pids=$(ps -eo stat,pid,cmd | awk '$1 ~ "Z" {print $2}')

    # Check if there are any zombie processes
    if [ -z "$zombies" ]; then
        echo "No zombie processes found."
    else
        echo "Killing zombie processes..."
        for pid in $zombies; do
            # Send SIGKILL signal to the zombie process
            kill -9 $pid
            echo "Killed zombie process with PID: $pid"
        done
    fi
}