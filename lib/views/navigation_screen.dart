import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/views/home_screen.dart';
import 'package:medilink/views/Hospitals.dart';
import 'package:medilink/views/chat_screen.dart';
import 'package:medilink/views/Pharmacies.dart'; // or Medicines screen if separate
import 'package:medilink/views/profile_screen.dart'; // you'll create this if not yet done

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  // Screens list — order matches bottom nav
  final List<Widget> _screens = [
    HomeScreen(),
    Hospitals(),
    ChatScreen(),
    Pharmacies(), // replace with your MedicinesScreen() when ready
    ProfileScreen(), // placeholder for now
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Use IndexedStack to keep screen states alive
      body: IndexedStack(index: _selectedIndex, children: _screens),

      // ✅ Conditionally hide bottom bar on Chat screen
      bottomNavigationBar: _selectedIndex == 2
          ? null
          : Container(
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
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  backgroundColor: Colors.white,
                  selectedItemColor: const Color(AppColor.primary),
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
