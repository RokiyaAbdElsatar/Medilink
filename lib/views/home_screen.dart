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
  // Emergency numbers list (Egypt first)
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

  // Show emergency dialog
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

  // Flag emoji or code
  Widget _getCountryFlag(String country) {
    final flags = {
      "Egypt": "EG",
      "USA / Canada": "US",
      "Europe (EU)": "EU",
      "UK": "GB",
      "Australia": "AU",
      "India": "IN",
      "China": "CN",
      "Japan": "JP",
      "Brazil": "BR",
      "South Africa": "ZA",
    };
    return Text(flags[country] ?? "??", style: const TextStyle(fontSize: 24));
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

              // Background arc shape
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
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(600, 400),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                            builder: (context) => CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                ),
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer(),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(
                                Icons.notifications_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationScreen(),
                                  ),
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ],
              ),

              // Medicine container
              Container(
                width: width * 0.9,
                height: height * 0.17,
                decoration: BoxDecoration(
                  color: const Color(AppColor.primary),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(width * 0.03),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/Vector.png",
                          width: width * 0.1,
                        ),
                        SizedBox(width: width * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Aspirin",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "One daily",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "100 mg",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(AppColor.doneChoose),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.005,
                          ),
                          child: const Text(
                            "Mark as taken",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.015),
                    Container(
                      height: height * 0.04,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Color(AppColor.primary),
                                size: 18,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Wed, 10 Sep 2025",
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Color(AppColor.primary),
                                size: 18,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "10:00 - 10:30 AM",
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.04),

              // Suggested Hospitals
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
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
                              builder: (context) => NavigationScreen(index: 1),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF106B96),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_sharp, size: 12),
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

      // FAB - Opens Emergency Dialog (No Call)
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
