from fastapi import FastAPI
from pydantic import BaseModel
import requests

app = FastAPI()

API_KEY = "YOUR_API_KEY_HERE"

# 🧠 ذاكرة المحادثة لكل مستخدم
user_sessions = {}

class ChatRequest(BaseModel):
    user_id: str
    message: str

@app.post("/chatbot")
def chatbot(req: ChatRequest):
    user_id = req.user_id
    user_message = req.message.strip()

    # ✅ لو المستخدم لسه داخل لأول مرة
    if user_id not in user_sessions:
        user_sessions[user_id] = []
        opening_message = (
            "👨‍⚕️ أهلاً بك! أتمنى لك الشفاء العاجل ❤️\n"
            "من فضلك احكيلي عن الأعراض اللي بتحسي بيها عشان نبدأ التحليل."
        )
        user_sessions[user_id].append({"role": "model", "content": opening_message})

    # 🧠 أضف رسالة المستخدم للتاريخ
    user_sessions[user_id].append({"role": "user", "content": user_message})

    # 🧠 البرومبت الأساسي اللي هيخلي Gemini يتصرف كدكتور ذكي
    full_history_text = "\n".join(
        [f"{m['role']}: {m['content']}" for m in user_sessions[user_id][-8:]]
    )

    data = {
        "contents": [{
            "parts": [{
                "text": f"""
أنت شات بوت طبي ذكي. تحدث مع المستخدم كأنك طبيب حقيقي.
ابدأ الحوار دائمًا بسؤال عن الأعراض فقط أول مرة، 
لكن بعد كده لا تكرر الترحيب أو نفس الجمل العامة.

حلل الأعراض تدريجيًا من خلال أسئلة بسيطة وواضحة مثل:
- هل في كحة؟
- هل في حرارة؟
- هل في ألم في الصدر أو الحلق؟
- هل في دوخة أو تعب؟

كل مرة اسأل سؤال واحد بناءً على الرد السابق.
وفي النهاية، لما تجمع كفاية أعراض:
1. قل التشخيص المحتمل.
2. اقترح العلاج المبدئي في البيت.
3. حدد متى لازم يزور الطبيب.
4. حدد نوع الطبيب المناسب.

المحادثة السابقة:
{full_history_text}

اكتب الرد التالي للطبيب الآن بناءً على آخر رسالة من المستخدم.
"""
            }]
        }]
    }

    url = "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent"
    headers = {"Content-Type": "application/json"}
    params = {"key": API_KEY}

    response = requests.post(url, headers=headers, params=params, json=data)
    result = response.json()

    reply = result["candidates"][0]["content"]["parts"][0]["text"]

    # ✅ حفظ رد البوت في سجل المحادثة
    user_sessions[user_id].append({"role": "model", "content": reply})

    return {"reply": reply}
