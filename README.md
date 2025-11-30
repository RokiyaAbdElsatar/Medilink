# 🩺 Medilink — Medical Appointment & Telehealth App

**Medilink** is a DEPI final-project that connects patients with healthcare providers through a clean Flutter mobile app and a lightweight Python backend (FastAPI / Uvicorn).  


<img width="1700" height="970" alt="MediLink (2)" src="https://github.com/user-attachments/assets/ecce3f7b-a22c-4239-9c2c-7ab5362bc9fd" />


---

## 🚀 Project Overview

Medilink aims to simplify access to medical services by providing:
- Searchable **hospital list** and details
- User **profile** with a saved profile image
- **Appointment booking** system for patients
- A lightweight **chat-bot** / assistant service (experimental)
- RESTful **backend APIs** served with FastAPI (Uvicorn)
- Flutter frontend for Android/iOS

## 🏥 Admin Booking Management

The Medilink system includes an administrative module that allows hospital staff to:

- View incoming appointment requests
- Accept or reject bookings
- Update booking status in real-time (powered by Firebase Firestore)
- Keep track of pending, approved, and rejected appointments

This ensures a complete and smooth workflow between patients and healthcare providers.


---

## 🧭 Key Features

- **Hospitals feed**: lists hospitals with names, addresses and quick actions (call / directions / details).
- **Appointments**: patients can create and view their appointments. The appointment data stored in firebase.
- **Profile management**: profile image is stored locally (e.g. using `SharedPreferences` on the client).
- **Chat bot**: a separate microservice (chat_bot) used to prototype conversational assistance.
- **Admin Dashboard**: Hospital administrators can review all booking requests and either **accept** or **reject** them. Each appointment has an approval status that updates in real-time via Firebase Firestore.
- **Responsive UI**: Flutter screens and reusable cards for hospital items, appointment cards and profile screens.
- **Developer-friendly**: backend runs with `uvicorn --reload` for fast local development.

---

## 📂 Project Structure (example)

```
frontend_flutter/         # Flutter application
├── lib/
│   ├── core/
│         └── constant/
│   ├── models/
│   ├── services/
│   ├── views/
│   ├── widgets/
│   └── main.dart

backend/
├── main.py                # FastAPI app (entry)
├── chat_bot.py            # experimental chatbot FastAPI app
└── requirements.txt       # for download the requirements
```
---
## 🛠 Tech Stack

- Frontend: **Flutter (Dart)**
- Backend: **Python** with **FastAPI** (served with Uvicorn)
- Database: **Firebase Firestore**
  - Stores users, hospitals, appointments
  - Includes **role-based access** (Admin / User) to control booking approvals
- Authentication: **Firebase Authentication**
  - Handles login and identifies whether the logged-in account is Admin
- Authorization: **Firestore Security Rules**
  - Enforces Admin privileges for accepting or rejecting bookings
- Local Storage: `SharedPreferences` (for saving profile image path locally on device)


---

### 🔌 Backend IP Configuration

Since the backend (FastAPI) and the chatbot service run locally,  
you must replace `localhost` with your machine's **local IP address** in the Flutter app.

Example:

Instead of:
http://localhost:8000/api/

Use:
http://YOUR_LOCAL_IP:8000/api/

To find your local IP:
- Windows: run `ipconfig` → use the IPv4 Address  
- macOS / Linux: run `ifconfig`

Make sure your phone/emulator and your backend machine are on the **same Wi-Fi network**.

This is required for:
- Main Medilink API (FastAPI)
- ChatBot service (running on another port, e.g., 7000)

---

## ⚙️ Run Locally — Backend

Make sure you have Python 3.9+ and the packages installed.

1. Create a venv and install deps:

```bash
python -m venv .venv
source .venv/bin/activate   # macOS / Linux
.venv\Scripts\activate    # Windows PowerShell

pip install -r requirements.txt
```

2. Run the main API (common development command used while developing Medilink):

```bash
# from backend/ directory
python -m uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

3. If you're running the experimental chat service:

```bash
python -m uvicorn chat_bot:app --host 0.0.0.0 --port 7000 --reload
```

(These commands were used in development logs while testing Uvicorn and the chat bot.)

---

## ▶️ Run Locally — Flutter Frontend

1. Install Flutter SDK and set up Android/iOS tooling.
2. From the `frontend_flutter/` directory:

```bash
flutter pub get
flutter run
```

---

## 🧪 Notes & Troubleshooting

- If your hospitals list fails to load, check backend connectivity and CORS settings; also confirm the backend process started successfully (watch the Uvicorn logs).
- If you see `INFO: Will watch for changes...` in your terminal, Uvicorn is running in reload mode — good for development.
- For API errors, inspect the backend logs and verify request paths and expected JSON schema.
- When integrating the chat bot, make sure the chat service port (e.g., 7000) doesn't conflict with other services.

---

## 📁 Example Git Commands

```bash
# clone repository
git clone https://github.com/RokiyaAbdElsatar/Medilink.git
cd Medilink

# create and switch to a new feature branch
git checkout -b feature/appointments

# pull latest changes on main
git pull origin main
```

---

## 🧑‍💻 Authors

**Rokiya Abd Elsatar**

**Omar Ahmed El Said**

**Marwan Hamed Abdo**

**Yomna Elsayed Mohamed**

**Mohamed Karem Kelila**


---

## 📄 License

This project is for educational use. Add an open-source license like MIT if you plan to publish it.

---


