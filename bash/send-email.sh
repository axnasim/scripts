#!/bin/bash

# This script sends an email using the mail command.
# It requires the following environment variables to be set:
# - EMAIL_FROM: The sender's email address
# - EMAIL_TO: The recipient's email address
# - EMAIL_SUBJECT: The subject of the email
# - EMAIL_BODY: The body of the email
# - EMAIL_ATTACHMENT: The path to the attachment (optional)
# - EMAIL_SMTP_SERVER: The SMTP server to use (optional)
# - EMAIL_SMTP_PORT: The SMTP port to use (optional)
# - EMAIL_SMTP_USERNAME: The username to use for authentication (optional)
# - EMAIL_SMTP_PASSWORD: The password to use for authentication (optional)  
# - EMAIL_SMTP_TLS: Whether to use TLS (optional, default is false)
# - EMAIL_SMTP_SSL: Whether to use SSL (optional, default is false)


# Check if the mail command is available
if ! command -v mail &> /dev/null
then
    echo "Error: mail command not found. Please install it to send emails."
    exit 1
fi

# Check if the required environment variables are set
if [ ! -z "${EMAIL_FROM}" ] && [ ! -z "${EMAIL_TO}" ] && [ ! -z "${EMAIL_SUBJECT}" ] && [ ! -z "${EMAIL_BODY}" ]; then
    # Set the default values for optional variables
    EMAIL_SMTP_SERVER=${EMAIL_SMTP_SERVER:-"smtp.example.com"}
    EMAIL_SMTP_PORT=${EMAIL_SMTP_PORT:-587}
    EMAIL_SMTP_USERNAME=${EMAIL_SMTP_USERNAME:-""}
    EMAIL_SMTP_PASSWORD=${EMAIL_SMTP_PASSWORD:-""}
    EMAIL_SMTP_TLS=${EMAIL_SMTP_TLS:-false}
    EMAIL_SMTP_SSL=${EMAIL_SMTP_SSL:-false}

    # Construct the mail command
    MAIL_CMD="mail -s \"${EMAIL_SUBJECT}\" -a \"From: ${EMAIL_FROM}\" \"${EMAIL_TO}\""

    # Add the attachment if provided
    if [ ! -z "${EMAIL_ATTACHMENT}" ]; then
        MAIL_CMD+=" -a \"${EMAIL_ATTACHMENT}\""
    fi

    # Send the email
    echo "${EMAIL_BODY}" | ${MAIL_CMD}

else
    echo "Error: Required environment variables are not set."
fi
# Check if the mail command was successful
if [ $? -eq 0 ]; then
    echo "Email sent successfully."
else
    echo "Error: Failed to send email."
fi
