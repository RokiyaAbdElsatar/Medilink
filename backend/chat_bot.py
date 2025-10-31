from fastapi import FastAPI
from pydantic import BaseModel
import requests

app = FastAPI()

API_KEY = "AIzaSyBN7yYk6sJpt5Yc507SjNTySB2tCtV6gbQ"

class ChatRequest(BaseModel):
    message: str

@app.post("/chatbot")
def chatbot(req: ChatRequest):
    print("📩 Received message:", req.message)  # ← دي مهمة جدًا
    url = "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent"
    headers = {"Content-Type": "application/json"}
    params = {"key": API_KEY}
    data = {
        "contents": [{"parts": [{"text": req.message}]}]
    }

    response = requests.post(url, headers=headers, params=params, json=data)
    print("✅ Gemini status:", response.status_code)
    print("🔹 Response JSON:", response.text)  # ← عشان نتأكد من الرد

    result = response.json()

    # استخراج الرد من النتيجة
    reply = result["candidates"][0]["content"]["parts"][0]["text"]
    return {"reply": reply}
