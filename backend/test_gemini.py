import requests

API_KEY = "AIzaSyBN7yYk6sJpt5Yc507SjNTySB2tCtV6gbQ"

url = "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent"
headers = {"Content-Type": "application/json"}
params = {"key": API_KEY}
data = {
    "contents": [{"parts": [{"text": "Hello Gemini!"}]}]
}

response = requests.post(url, headers=headers, params=params, json=data)

print("🔹 Status code:", response.status_code)
print("🔹 Response:", response.text)
