import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/models/hospital_list.dart';
import 'package:medilink/views/drawer%20screen.dart';
import 'package:medilink/views/navigation_screen.dart';
import 'package:medilink/views/notification_screen.dart';
import 'package:medilink/widgets/hospital_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _emergencyNumbers = [
    {"country": "Egypt", "number": "123"},
    {"country": "USA / Canada", "number": "911"},
    {"country": "Europe (EU)", "number": "112"},
    {"country": "UK", "number": "999"},
    {"country": "Australia", "number": "000"},
    {"country": "India", "number": "112"},
    {"country": "China", "number": "120 / 110 / 119"},
    {"country": "Japan", "number": "119"},
    {"country": "Brazil", "number": "190 / 192 / 193"},
    {"country": "South Africa", "number": "10111"},
  ];

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.emergency, color: Colors.red),
              SizedBox(width: 8),
              Text(
                "Emergency Numbers",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _emergencyNumbers.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, thickness: 0.5),
              itemBuilder: (context, index) {
                final entry = _emergencyNumbers[index];
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: _getCountryFlag(entry['country']!),
                  title: Text(
                    entry['country']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  trailing: SelectableText(
                    entry['number']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(AppColor.medicationColor),
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Close",
                style: TextStyle(color: Color(0xFF106B96)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getCountryFlag(String country) {
    final flags = {
      "Egypt": "🇪🇬",
      "USA / Canada": "🇺🇸",
      "Europe (EU)": "🇪🇺",
      "UK": "🇬🇧",
      "Australia": "🇦🇺",
      "India": "🇮🇳",
      "China": "🇨🇳",
      "Japan": "🇯🇵",
      "Brazil": "🇧🇷",
      "South Africa": "🇿🇦",
    };
    return Text(flags[country] ?? "🏥", style: const TextStyle(fontSize: 24));
  }

  String userName = "Loading...";

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  Future<void> getUserName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('patients')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          setState(() {
            userName = doc.data()?['name'] ?? "Unknown User";
          });
        } else {
          setState(() {
            userName = "No user data";
          });
        }
      }
    } catch (e) {
      print("Error fetching user name: $e");
      setState(() {
        userName = "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      drawer: const DrawerScreen(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.07),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -height * 0.25,
                    right: -width * 0.05,
                    child: Container(
                      width: width * 1.3,
                      height: height * 0.45,
                      decoration: const BoxDecoration(
                        color: Color(AppColor.background),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(600, 400)),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                            builder: (context) => CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: const Icon(Icons.menu, color: Colors.black),
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer(),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.notifications_outlined,
                                  color: Colors.black),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationScreen()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      const Text("Hello,", style: TextStyle(fontSize: 24)),
                      Text(
                        userName,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ],
              ),

              // ✅ Medical Tips Slider
              CarouselSlider(
                options: CarouselOptions(
                  height: height * 0.22,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  viewportFraction: 0.9,
                  aspectRatio: 16 / 9,
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  {
                    "image": "assets/images/advice.png",
                    "title": "اشرب كمية كافية من المياه 💧",
                    "desc":
                        "الماء يساعد على تنشيط الدورة الدموية وتحسين التركيز والطاقة.",
                  },
                  {
                    "image": "assets/images/advice.png",
                    "title": "نم بشكل كافي 😴",
                    "desc":
                        "النوم من 7 إلى 8 ساعات يوميًا يحافظ على صحة القلب والمناعة.",
                  },
                  {
                    "image": "assets/images/advice.png",
                    "title": "مارس الرياضة 🏃‍♀️",
                    "desc":
                        "حتى 30 دقيقة مشي يوميًا تقيك من أمراض القلب والسمنة.",
                  },
                  {
                    "image": "assets/images/advice.png",
                    "title": "كل خضار وفواكه 🥗",
                    "desc":
                        "مصدر غني بالفيتامينات والمعادن الضرورية لصحتك اليومية.",
                  },
                ].map((tip) {
                  return Builder(builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.015),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F4F9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: width * 0.03),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              tip["image"]!,
                              width: width * 0.25,
                              height: height * 0.16,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: width * 0.04),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: width * 0.03),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tip["title"]!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF106B96),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.008),
                                  Text(
                                    tip["desc"]!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                }).toList(),
              ),

              SizedBox(height: height * 0.04),

              // Suggested Hospitals
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Suggested Hospitals",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF106B96),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NavigationScreen(index: 1),
                            ),
                          );
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF106B96),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_sharp, size: 12),
                    ],
                  ),
                ],
              ),

              SizedBox(height: height * 0.015),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 6,
                  childAspectRatio: 0.86,
                ),
                itemCount: 2,
                itemBuilder: (context, index) => hospitalCard(
                  h: MainHospitals[index],
                  facilities: MainHospitals[index]["facilities"],
                ),
              ),
              SizedBox(height: height * 0.06),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "emergency_btn",
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF106B96),
        onPressed: _showEmergencyDialog,
        child: Image.asset("assets/images/Vector1.png"),
      ),
    );
  }
}
