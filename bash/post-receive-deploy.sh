#!/bin/bash

# post-receive script to automatically deploy changes to a web server

while read oldrev newrev refname; do
  # Get the name of the branch that was pushed
  branch=$(git rev-parse --symbolic --abbrev-ref $refname)

  # Define the path to the deployment directory
  DEPLOY_DIR="/var/www/mywebsite"

  # Define a log file
  LOG_FILE="/var/log/deploy.log"

  # Function to log messages
  log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
  }

  # Only deploy if the main branch was updated
  if [ "$branch" == "main" ]; then
    log "Received push to main branch. Deploying..."

    # Change to the deployment directory
    cd "$DEPLOY_DIR" || {
      log "Error: Could not change to deployment directory: $DEPLOY_DIR"
      exit 1
    }

    # Pull the latest changes from the repository
    git pull origin main 2>&1 | tee -a "$LOG_FILE"

    # Check if the pull was successful
    if [ $? -ne 0 ]; then
      log "Error: Git pull failed."
      exit 1
    fi

    log "Successfully updated code in $DEPLOY_DIR"

    # Example: Restart a web server (replace with your actual command)
    log "Restarting web server..."
    sudo systemctl restart apache2 2>&1 | tee -a "$LOG_FILE"

    if [ $? -ne 0 ]; then
      log "Error: Web server restart failed."
      exit 1
    fi

    log "Web server restarted successfully."

    log "Deployment complete."

  else
    log "Received push to $branch branch.  No deployment needed."
  fi
done

exit 0
