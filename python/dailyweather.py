import requests
import os
from plyer import notification

API_KEY = os.getenv("OPENWEATHER_API_KEY")  # Load API key from environment variable
CITY = "New York"
url = f"http://api.openweathermap.org/data/2.5/weather?q={CITY}&appid={API_KEY}&units=metric"

try:
    response = requests.get(url)
    response.raise_for_status()  # Raise error for bad response
    data = response.json()
    
    if "main" in data and "weather" in data:
        temp = data["main"]["temp"]
        desc = data["weather"][0]["description"]
        notification.notify(
            title="Today's Weather",
            message=f"{CITY}: {temp}°C, {desc}",
            timeout=10
        )
    else:
        print("Unexpected response format:", data)
except requests.exceptions.RequestException as e:
    print("Error fetching weather data:", e)