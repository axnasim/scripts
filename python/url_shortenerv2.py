#!/usr/bin/env python3

import hashlib
import urllib.parse
import json
import os

class URLShortener:
    def __init__(self, storage_file='urls.json'):
        self.storage_file = storage_file
        self.url_mapping = self._load_urls()

    def _load_urls(self):
        try:
            with open(self.storage_file, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            return {}
        except json.JSONDecodeError:
            print("Error decoding JSON file. Starting with an empty URL mapping.")
            return {}

    def _save_urls(self):
        try:
            with open(self.storage_file, 'w') as f:
                json.dump(self.url_mapping, f, indent=4)  # Added indent for readability
        except IOError as e:
            print(f"Error saving URLs to file: {e}")

    def _generate_short_code(self, url):
        url_hash = hashlib.sha256(url.encode()).hexdigest()[:8]
        return url_hash

    def shorten_url(self, original_url):
        if not self._is_valid_url(original_url):
            raise ValueError("Invalid URL format")

        # Directly check if the URL exists in the values of the dictionary
        short_code = next((k for k, v in self.url_mapping.items() if v == original_url), None)
        if short_code:
            return short_code

        short_code = self._generate_short_code(original_url)
        # Handle collisions
        while short_code in self.url_mapping:
            short_code = self._generate_short_code(original_url + "_salt")  # Add a salt to avoid infinite loops

        self.url_mapping[short_code] = original_url
        self._save_urls()
        return short_code

    def get_original_url(self, short_code):
        return self.url_mapping.get(short_code)

    def _is_valid_url(self, url):
        try:
            result = urllib.parse.urlparse(url)
            return all([result.scheme, result.netloc])
        except:
            return False

# Example usage
if __name__ == "__main__":
    shortener = URLShortener()

    while True:
        print("\n1. Shorten URL")
        print("2. Retrieve URL")
        print("3. Exit")
        choice = input("Choose an option: ")

        if choice == "1":
            url = input("Enter URL to shorten: ")
            try:
                short_code = shortener.shorten_url(url)
                print(f"Shortened URL: http://yourdomain.com/{short_code}")
            except ValueError as e:
                print(f"Error: {e}")
        elif choice == "2":
            short_code = input("Enter short code: ")
            original_url = shortener.get_original_url(short_code)
            if original_url:
                print(f"Original URL: {original_url}")
            else:
                print("Short code not found")
        elif choice == "3":
            break
        else:
            print("Invalid choice")