import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medilink/views/login_screen.dart';
import 'package:medilink/views/navigation_screen.dart';
import 'package:medilink/views/rate_app_screen.dart';
import 'package:medilink/views/support_faq_screen.dart';
import 'package:medilink/views/user_bookings_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String userName = "Loading...";
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    getUserName();
    _loadProfileImage();
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

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      backgroundColor: const Color(0xFFF6F6F6),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const AssetImage("assets/images/Ellipse 9.png") as ImageProvider,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              userName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationScreen(index: 4),
                  ),
                );
              },
              child: const Text(
                "View Profile",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          const Divider(),

          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.star_outline),
                title: const Text('Rate App'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RateAppScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.headset_mic),
                title: const Text('Support/FAQ'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SupportFAQScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.list_alt_outlined),
                title: const Text('My Bookings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserBookingsScreen()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 200),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
