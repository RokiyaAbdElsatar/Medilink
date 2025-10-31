import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medilink/views/login_screen.dart';
import 'package:medilink/views/navigation_screen.dart';
import 'package:medilink/views/profile_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
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
    return Drawer(
      width: 220,
      backgroundColor: const Color(0xFFF6F6F6),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: CircleAvatar(
                  radius: 40,
                  child: Image(
                    image: AssetImage("assets/images/Ellipse 9.png"),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              userName, // ✅ اسم اليوزر من Firebase
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
              child: Text(
                "View Profile",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.question_mark),
            title: const Text('My Questions'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('Rate App'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.headset_mic),
            title: const Text('Support/FAQ'),
            onTap: () {},
          ),
          const SizedBox(height: 225),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
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
