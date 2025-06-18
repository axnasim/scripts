   #!/bin/bash
   # A script to scrape a website and extract data

   # Define a log function
    log() {
         local message="$1"
         echo "$(date '+%Y-%m-%d %H:%M:%S') - $message"
    }   

   # Define a cleanup function
   cleanup() {
       log "Cleaning up..."
       rm -f /tmp/website.html /tmp/data.txt
       log "Cleanup completed."
   }
    # Trap the INT signal and call the cleanup function
    # Trap multiple signals and call the cleanup function
    trap cleanup INT HUP QUIT ABRT PIPE USR1 EXIT


   # Check if curl is installed
   log "Checking if curl is installed..."
   if ! command -v curl &> /dev/null; then
       log "curl is not installed. Exiting."
       exit 1
   fi

    # Check if grep is installed
   log "Checking if grep is installed..."
    if ! command -v grep &> /dev/null; then
         log "grep is not installed. Exiting."
         exit 1
    fi

   # Download the website
   log "Downloading the website..."
    # Using curl to download the website
   curl -s -o /tmp/website.html https://www.rottentomatoes.com/ 
   # Using wget to download the website
   #wget -O /tmp/website.html https://www.rottentomatoes.com/      

   if [ $? -ne 0 ]; then
        log "An error occurred while downloading the website. Exiting."
        exit 1
   fi
   # Check if the download was successful
   log "Checking if the download was successful..." 

# Extract the data using pup for robust HTML parsing
curl -s -o "/tmp/website.html" "https://www.rottentomatoes.com/"
if ! command -v pup &> /dev/null; then
    log "pup is not installed. Please install pup for robust HTML parsing. Exiting."
    exit 1
fi
cat /tmp/website.html | pup 'h1 text{}' > /tmp/data.txt

   # Check if the extraction was successful
   log "Checking if the extraction was successful..."
   if [ $? -ne 0 ]; then
# Display the data
log "Displaying the data..."
if [ -s /tmp/data.txt ]; then
    cat /tmp/data.txt
   # Display the data
   log "Displaying the data..."
   cat /tmp/data.txt

   # Check if data.txt is not empty before logging success
   if [ ! -s /tmp/data.txt ]; then
       log "No data was extracted. Exiting."
       exit 1
   fi

   # Exit with success
   log "Script completed successfully."
   exit 0data.txt

   # Exit with success
   log "Script completed successfully."
   exit 0