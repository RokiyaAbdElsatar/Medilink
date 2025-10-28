import 'package:flutter/material.dart';
import 'package:medilink/constant/appcolor.dart';
import 'package:medilink/views/Hospitals.dart';
import 'package:medilink/views/chat_screen.dart';
import 'package:medilink/views/home_screen.dart';
import 'package:medilink/views/medicines_screen.dart';
import 'package:medilink/views/onboarding.dart';
import 'package:medilink/views/profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int pageIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    const Hospitals(),
    const ChatScreen(),
    const MedicinesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex, children: pages),

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
            currentIndex: pageIndex,
            onTap: (index) {
              setState(() {
                pageIndex = index;
              });
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
