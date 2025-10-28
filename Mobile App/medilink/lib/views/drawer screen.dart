import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      backgroundColor: Color(0xFFF6F6F6),
      child: ListView(
        children: [
          SizedBox(height: 30),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CircleAvatar(
                  radius: 40,
                  child: Image.asset("assets/images/Ellipse 9.png"),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "James Anderson",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "View Profile",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.question_mark),
            title: Text('My Questions'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.star_outline),
            title: Text('Rate App'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.headset_mic),
            title: Text('Support/FAQ'),
            onTap: () {},
          ),

          SizedBox(height: 225),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
