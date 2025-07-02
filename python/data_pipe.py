import boto3
import hashlib
from cryptography.fernet import Fernet
import os
import logging
from datetime import datetime

# Configure logging to output messages to the console
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


class DataCache:
    """
    A simple in-memory data cache with Least Recently Used (LRU) eviction policy.
    """
    def __init__(self, max_size=100):
        """
        Initializes the DataCache with a maximum size.

        Args:
            max_size (int): The maximum number of items the cache can hold.
        """
        self.max_size = max_size
        # self.cache: Dictionary to store cached data.  Key is a hash of the data, value is a tuple: (data, last_used timestamp)
        self.cache = {}
        # self.lru_queue: List to keep track of the order in which items were accessed (LRU).
        self.lru_queue = []  # List of keys, MRU (Most Recently Used) at end, LRU (Least Recently Used) at beginning

    def add_data(self, data):
        """
        Adds data to the cache. If the cache is full, it evicts the least recently used item.

        Args:
            data (dict): The data to be added to the cache.  It's expected to be a dictionary.
        """
        # Create a unique key for the data using MD5 hashing.
        key = hashlib.md5(str(data).encode()).hexdigest()

        if key in self.cache:
            # If the key already exists, update the last_used timestamp and move it to the end of the LRU queue.
            self.cache[key] = (data, datetime.now())
            self.lru_queue.remove(key)  # Remove from its current position
            self.lru_queue.append(key)  # Move to the end (most recently used)
            return

        if len(self.cache) >= self.max_size:
            # If the cache is full, evict the least recently used item.
            lru_key = self.lru_queue.pop(0)  # Get the key of the LRU item (first in the queue)
            del self.cache[lru_key]  # Remove the item from the cache
            logging.info(f"Cache full, evicting key: {lru_key}")

        # Add the new data to the cache and the LRU queue.
        self.cache[key] = (data, datetime.now())
        self.lru_queue.append(key) #add new data to the end
        logging.info(f"Added data with key: {key} to cache.")

    def get_data(self, sensitivity="all"):
        """
        Retrieves data from the cache based on the specified sensitivity level.

        Args:
            sensitivity (str):  The sensitivity level to filter the data ("sensitive", "non-sensitive", or "all").  Defaults to "all".

        Returns:
            list: A list of data items that match the specified sensitivity level.
        """
        result = []
        for key, (data, last_used) in self.cache.items():
            if sensitivity == "all" or data.get("sensitivity") == sensitivity:
                # If sensitivity matches or "all" is specified, add the data to the result list.
                result.append(data)

                # Update LRU: move the accessed key to the end of the queue.
                self.lru_queue.remove(key)
                self.lru_queue.append(key)
                self.cache[key] = (data, datetime.now())  # Update last_used timestamp

        return result


def upload_data_to_s3(cache, s3_bucket_name):
    """
    Uploads data from the DataCache to Amazon S3, separating sensitive and non-sensitive data.
    Sensitive data is encrypted before upload.

    Args:
        cache (DataCache): The DataCache object containing the data to upload.
        s3_bucket_name (str): The name of the S3 bucket to upload the data to.
    """
    # Create an S3 client using boto3.
    s3 = boto3.client('s3')

    # Get the encryption key from the environment variable.
    encryption_key = os.environ.get('ENCRYPTION_KEY')
    if not encryption_key:
        raise ValueError("ENCRYPTION_KEY environment variable not set.")

    # Initialize Fernet for encryption.  Fernet uses AES encryption.
    fernet = Fernet(encryption_key.encode('utf-8'))  # Ensure key is bytes

    # Get sensitive and non-sensitive data from the cache.
    sensitive_data = cache.get_data(sensitivity="sensitive")
    non_sensitive_data = cache.get_data(sensitivity="non-sensitive")

    try:
        # Upload sensitive data to S3, encrypting it first.
        for data in sensitive_data:
            data_str = str(data).encode('utf-8')  # Convert data to bytes
            encrypted_data = fernet.encrypt(data_str)  # Encrypt the data
            filename = hashlib.md5(data_str).hexdigest() + ".enc"  # Generate a unique filename
            s3.put_object(Bucket=s3_bucket_name, Key=f"sensitive/{filename}", Body=encrypted_data) #upload to s3
            logging.info(f"Uploaded sensitive data to s3://{s3_bucket_name}/sensitive/{filename}")

        # Upload non-sensitive data to S3 (without encryption).
        for data in non_sensitive_data:
            data_str = str(data).encode('utf-8')  # Convert data to bytes
            filename = hashlib.md5(data_str).hexdigest() + ".txt"  # Generate a unique filename
            s3.put_object(Bucket=s3_bucket_name, Key=f"non-sensitive/{filename}", Body=data_str)  #upload to s3
            logging.info(f"Uploaded non-sensitive data to s3://{s3_bucket_name}/non-sensitive/{filename}")

    except Exception as e:
        # Log any errors that occur during the S3 upload process.
        logging.error(f"Error uploading data to S3: {e}")
        raise  # Re-raise the exception so the calling code knows the upload failed


if __name__ == '__main__':
    # Example Usage
    # Set the encryption key in the environment variable.  **In a real application, use a secure key management system like AWS KMS.**
    os.environ['ENCRYPTION_KEY'] = 'YOUR_SECRET_KEY_1234567890123456789012'  # Replace with a strong 32-byte key

    # Create a DataCache instance with a maximum size of 5 items.
    cache = DataCache(max_size=5)

    # Add data to the cache (some sensitive, some non-sensitive).
    cache.add_data({"data": "sensitive data 1", "sensitivity": "sensitive"})
    cache.add_data({"data": "non-sensitive data 1", "sensitivity": "non-sensitive"})
    cache.add_data({"data": "sensitive data 2", "sensitivity": "sensitive"})
    cache.add_data({"data": "non-sensitive data 2", "sensitivity": "non-sensitive"})
    cache.add_data({"data": "sensitive data 3", "sensitivity": "sensitive"})  # Fill cache
    cache.add_data({"data": "non-sensitive data 3", "sensitivity": "non-sensitive"})  # Cause eviction (LRU)

    # Specify the name of the S3 bucket to upload to.  **Replace with your actual bucket name.**
    s3_bucket_name = "your-s3-bucket-name"

    try:
        # Upload the data from the cache to S3.
        upload_data_to_s3(cache, s3_bucket_name)
        print("Data upload complete.")
    except Exception as e:
        # If an error occurred during the upload, print an error message.
        print(f"Data upload failed: {e}")
