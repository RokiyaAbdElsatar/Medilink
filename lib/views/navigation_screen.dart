import 'package:flutter/material.dart';
import 'package:medilink/constant/appcolor.dart';
import 'package:medilink/views/chat_screen.dart';
import 'package:medilink/views/home_screen.dart';
import 'package:medilink/views/hospitals_screen.dart';
import 'package:medilink/views/medicines_screen.dart';
import 'package:medilink/views/profile_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int pageIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    HospitalsScreen(),
    ChatScreen(),
    MedicinesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex, children: pages),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xFF106B96),
        onPressed: () {},
        child: Image(image: AssetImage("assets/images/Vector1.png")),
      ),

      bottomNavigationBar: SalomonBottomBar(
        curve: Curves.easeInOut,
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text("Home"),
            selectedColor: Color(AppColor.primary),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            title: Text("nearby"),
            selectedColor: Color(AppColor.primary),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            title: Text("AI Chat"),
            selectedColor: Color(AppColor.primary),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.medical_information_outlined),
            title: Text("Meds"),
            selectedColor: Color(AppColor.primary),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person_outline),
            title: Text("Profile"),
            selectedColor: Color(AppColor.primary),
          ),
        ],
      ),
    );
  }
}
