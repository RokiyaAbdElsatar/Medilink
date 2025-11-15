from fastapi import FastAPI, Query, HTTPException
from pydantic import BaseModel
import requests, math, random, json, os
from datetime import datetime
from typing import List

# === Random Data ===
randomPhones = [
    '01098765432', '01187654321', '01276543210', '01509876543',
    '01065432109', '01154321098', '01201234567', '01512345678',
    '01034567890', '01145678901', '01256789012', '01567890123',
    '01078901234', '01189012345', '01290123456', '01523456789',
    '01043210987', '01153210987', '01263210987', '01573210987'
]

randomAddresses = [
    '٣٥ شارع شهاب، المهندسين، الجيزة', '١٢ ميدان مصطفى محمود، المهندسين، الجيزة',
    '٢٢ شارع جامعة الدول العربية، الدقي، الجيزة', '٦ شارع النيل الأبيض، الدقي، الجيزة',
    '٤٠ شارع التحرير، باب اللوق، وسط البلد، القاهرة', '٢٨ شارع القصر العيني، السيدة زينب، القاهرة',
    'عمارة ٥، الحي الأول، التجمع الخامس، القاهرة الجديدة', 'قطعة رقم ٧، منطقة البنفسج ٩، التجمع الأول، القاهرة الجديدة',
    '٢ شارع أحمد عرابي، المنطقة الصناعية، مدينة العبور', '١٥ شارع جسر السويس، عين شمس، القاهرة',
    '٤٥ شارع الحجاز، ميدان المحكمة، مصر الجديدة، القاهرة', '٢٠ شارع بغداد، الكوربة، مصر الجديدة، القاهرة',
    '٨ شارع مراد، الجيزة', '٣٠ شارع الهرم الرئيسي، بجوار كايرو مول، الهرم، الجيزة',
    '١٠ شارع ٩، حدائق المعادي، القاهرة', '٢٥ شارع فؤاد، حلوان، القاهرة',
    '١ شارع شريف، عابدين، القاهرة', '٣٣ شارع سكة حديد حلوان، المعصرة، القاهرة',
    '٥٠ شارع العروبة، مساكن شيراتون، مصر الجديدة، القاهرة', '١٨ شارع السودان، إمبابة، الجيزة'
]

# === Facilities & Home Services ===
FACILITIES = [
    {"icon": "https://cdn-icons-png.freepik.com/512/8416/8416095.png", "name": "Intensive Care Unit"},
    {"icon": "https://cdn-icons-png.freepik.com/512/4434/4434351.png", "name": "Emergency Care"},
    {"icon": "https://cdn-icons-png.flaticon.com/512/9442/9442123.png", "name": "Surgery"},
    {"icon": "https://cdn-icons-png.freepik.com/512/1560/1560900.png", "name": "Pharmacy"},
    {"icon": "https://cdn-icons-png.freepik.com/512/3030/3030180.png", "name": "Laboratory"},
    {"icon": "https://cdn-icons-png.freepik.com/512/8127/8127256.png", "name": "X-Ray & Radiology"},
    {"icon": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxe5LN8aq3QnjqbvK0hCrDitzfzUtzLpPIgA&s", "name": "Maternity Ward"},
    {"icon": "https://cdn-icons-png.flaticon.com/512/9340/9340051.png", "name": "Pediatric Care"},
]

HOME_SERVICES = [
    {
        "icon": "https://cdn-icons-png.freepik.com/512/6870/6870436.png",
        "title": "Home Doctor Visit",
        "description": "qualified doctor visit your home for consultation and treatment",
        "price_range": "$50 - $100",
    },
    {
        "icon": "https://cdn-icons-png.flaticon.com/512/5845/5845950.png",
        "title": "Nursing Care",
        "description": "Professional Nursing Services For Post-Surgery Or Elderly Care",
        "price_range": "$100 - $200",
    },
    {
        "icon": "https://cdn-icons-png.freepik.com/512/9442/9442145.png",
        "title": "Physiotherapy at Home",
        "description": "Licensed physiotherapists provide rehab sessions at your home",
        "price_range": "$80 - $150",
    },
    {
        "icon": "https://cdn-icons-png.freepik.com/512/9063/9063843.png",
        "title": "Lab Tests at Home",
        "description": "Blood tests, urine analysis & health checkups at home",
        "price_range": "$30 - $90",
    },
]

app = FastAPI()

# === Review Storage ===
COMMENTS_FILE = "comments.json"

def load_comments():
    if os.path.exists(COMMENTS_FILE):
        with open(COMMENTS_FILE, "r", encoding="utf-8") as f:
            return json.load(f)
    return []

def save_comments():
    with open(COMMENTS_FILE, "w", encoding="utf-8") as f:
        json.dump(comments_db, f, ensure_ascii=False, indent=2)

comments_db = load_comments()

# === Models ===
class Review(BaseModel):
    hospital_name: str
    username: str
    rating: float
    comment: str
    address: str | None = None
    phone: str | None = None

# === Helpers ===
def calculate_distanceKm(lat1, lon1, lat2, lon2):
    R = 6371
    dlat = math.radians(lat2 - lat1)
    dlon = math.radians(lon2 - lon1)
    a = math.sin(dlat/2)**2 + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dlon/2)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    return R * c

def seeded_sample(seed: str, items: list, k: int):
    random.seed(seed)
    return random.sample(items, k=min(k, len(items)))

# === API Endpoints ===
@app.get("/hospitals")
def get_hospitals(
    city: str = Query("القاهرة", description="اسم المدينة (افتراضي: القاهرة)"),
    max_distance: float = Query(10.0, description="أقصى مسافة بالكيلومتر"),
    min_rating: float = Query(0.0, description="الحد الأدنى للتقييم")
):
    # ... (same logic as before) ...
    geo_url = "https://nominatim.openstreetmap.org/search"
    geo_params = {"q": city, "format": "json", "limit": 1}
    geo_response = requests.get(geo_url, params=geo_params, headers={"User-Agent": "HospitalFinder/1.0"})

    if geo_response.status_code != 200 or not geo_response.json():
        return {"error": f"لا يمكن العثور على المدينة: {city}"}

    geo_data = geo_response.json()[0]
    city_lat = float(geo_data["lat"])
    city_lon = float(geo_data["lon"])

    overpass_url = "https://overpass-api.de/api/interpreter"
    radius_m = max_distance * 1000

    query = f"""
    [out:json];
    (
      node["amenity"="hospital"](around:{radius_m},{city_lat},{city_lon});
      way["amenity"="hospital"](around:{radius_m},{city_lat},{city_lon});
      relation["amenity"="hospital"](around:{radius_m},{city_lat},{city_lon});
    );
    out center;
    """

    response = requests.get(overpass_url, params={"data": query}, headers={"User-Agent": "HospitalFinder/1.0"})
    if response.status_code != 200:
        return {"error": "لا يمكن الاتصال بـ Overpass API"}

    data = response.json()
    hospitals = []

    for element in data.get("elements", []):
        tags = element.get("tags", {})
        name = tags.get("name", "مستشفى بدون اسم")
        lat = element.get("lat") or element.get("center", {}).get("lat")
        lon = element.get("lon") or element.get("center", {}).get("lon")

        if not lat or not lon:
            continue

        distance = calculate_distanceKm(city_lat, city_lon, lat, lon)
        rating = len(name) % 6
        seed_str = f"{name}_{lat}_{lon}"

        facilities = seeded_sample(seed_str + "_fac", FACILITIES, k=random.randint(3, 6))
        home_services = seeded_sample(seed_str + "_srv", HOME_SERVICES, k=random.randint(2, 4))

        for service in home_services:
            base_low, base_high = map(int, service["price_range"].replace("$", "").split(" - "))
            variance = random.randint(-20, 30)
            low = max(20, base_low + variance)
            high = max(low + 20, base_high + variance)
            service["price_range"] = f"${low} - ${high}"

        if distance <= max_distance and rating >= min_rating:
            reviews = [r for r in comments_db if r["hospital_name"].lower() == name.lower()]
            hospitals.append({
                "name": name,
                "address": tags.get("addr:full") or tags.get("addr:street") or randomAddresses[(len(name) + int(lat * 1000)) % len(randomAddresses)],
                "phone": tags.get("phone") or tags.get("contact:phone") or randomPhones[len(name) % len(randomPhones)],
                "latitude": lat,
                "longitude": lon,
                "distance_km": round(distance, 2),
                "rating": rating,
                "reviews": reviews,
                "facilities": facilities,
                "home_services": home_services
            })

    hospitals.sort(key=lambda x: (x["distance_km"], -x["rating"]))

    return {
        "city": city,
        "coordinates": {"lat": city_lat, "lon": city_lon},
        "total_results": len(hospitals),
        "hospitals": hospitals
    }

@app.post("/reviews")
def add_review(review: Review):
    if not (0 <= review.rating <= 5):
        raise HTTPException(status_code=400, detail="التقييم يجب أن يكون بين 0 و 5")

    review_data = review.dict()
    review_data["timestamp"] = datetime.utcnow().isoformat()
    comments_db.append(review_data)
    save_comments()
    return {"message": "تمت إضافة التقييم بنجاح", "review": review_data}

@app.get("/reviews")
def get_all_reviews():
    return {"total_reviews": len(comments_db), "reviews": comments_db}
