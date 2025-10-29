import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/views/Hospitals.dart';
import 'package:medilink/views/Pharmacies.dart';
import 'package:medilink/views/chat_screen.dart';
import 'package:medilink/views/drawer%20screen.dart';
import 'package:medilink/views/notification_screen.dart';
import 'package:medilink/views/pharmacy_container.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _selectedIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  final List<String> urls = [
    "https://play-lh.googleusercontent.com/3Ayv-0-hV6MnV6EPq21gqo5ffL-2dplZUh7X797G1PLQcwnINF6vUQbWmxTKl-jMYFw",
    "https://m.edarabia.com/wp-content/uploads/2020/04/elezaby-pharmacy-cairo-egypt.jpg",
  ];

  final List<String> mainTexts = ["Misr Pharmacies", "El Ezaby Pharmacies"];

  final List<String> subTexts = ["200+ Branches", "330+ Branches"];

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

              // ✅ Background arc shape
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
                      // ✅ Top bar
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
                      const Text(
                        "James Anderson",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ],
              ),

              // ✅ Medicine container (responsive)
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

              // ✅ Pharmacies section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Suggested Pharmacies",
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
                              builder: (context) => const Pharmacies(),
                            ),
                          );
                        },
                        child: Text("See All", style: TextStyle(fontSize: 10)),
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
                itemBuilder: (context, index) => PharmacyContainer(
                  imgUrl: urls[index],
                  mainText: mainTexts[index],
                  subText: subTexts[index],
                ),
              ),
              SizedBox(height: height * 0.06),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) async {
              setState(() {
                _selectedIndex = index;
              });

              // --- Navigation Logic ---
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } else if (index == 1) {
                // Already on Hospitals Page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Hospitals()),
                );
              } else if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              } else if (index == 3) {
                // Medicines page (add your widget here)
              } else if (index == 4) {
                // Profile page (add your widget here)
              }
            },

            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF2B7EA1),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 10,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/Home.png',
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/Home active.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/hospital.png',
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/activeHospital.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Hospitals',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/Chat.png',
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/active chat.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Ai Chat',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/medicine.png',
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/activeMedicine.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Medicines',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/profile.png',
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/active profile.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
