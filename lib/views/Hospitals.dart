import 'package:flutter/material.dart';
import 'package:medilink/views/Pharmacies.dart';
import 'package:medilink/views/chat_screen.dart';
import 'package:medilink/views/drawer%20screen.dart';
import 'package:medilink/views/home_screen.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({super.key});

  @override
  State<Hospitals> createState() => _HospitalsState();
}

int _selectedIndex = 1;

final List<Map<String, dynamic>> hospitals = [
  {
    'name': 'As-Salam International',
    'branches': '50+ Branches',
    'image': 'assets/images/hospital1.png',
    'rating': 4,
  },
  {
    'name': 'Dar Al Fouad',
    'branches': '40+ Branches',
    'image': 'assets/images/hospital2.png',
    'rating': 4,
  },
  {
    'name': 'Shefa Hospital',
    'branches': '60+ Branches',
    'image': 'assets/images/hospital3.png',
    'rating': 4,
  },
  {
    'name': 'Cleopatra Group',
    'branches': '35+ Branches',
    'image': 'assets/images/hospital4.png',
    'rating': 4,
  },
  {
    'name': 'Egyptian Hospital',
    'branches': '45+ Branches',
    'image': 'assets/images/hospital5.png',
    'rating': 4,
  },
  {
    'name': 'Police Hospital',
    'branches': '30+ Branches',
    'image': 'assets/images/hospital6.png',
    'rating': 4,
  },
];

class _HospitalsState extends State<Hospitals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerScreen(),

      // ===== AppBar =====
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,

        title: const Text(
          "Hospitals",
          style: TextStyle(
            color: Color(0xFF0B7BA8),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // ===== Body =====
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            // --- Search Bar ---
            Container(
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEBF4FF),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 15),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                    size: 22,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Hospitals Grid ---
            Expanded(
              child: GridView.builder(
                itemCount: hospitals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = hospitals[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE2F1FA)),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            child: Image.asset(
                              item['image'],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item['name'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['branches'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  item['rating'],
                                  (i) => const Icon(
                                    Icons.star,
                                    color: Color(0xFFFFC107),
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ===== Bottom Navigation Bar =====
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
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });

              // --- Navigation Logic ---
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } else if (index == 1) {
                // Already on Hospitals Page
              } else if (index == 2) {
                Navigator.push(
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
