import 'package:flutter/material.dart';

import 'views/Nearby.dart' show NearbyScreen;
import 'views/Pharmacies.dart' show Pharmacies;

void main() {
  runApp(const MedilinkApp());
}

class MedilinkApp extends StatelessWidget {
  const MedilinkApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medilink',

      home: NearbyScreen(),
    );
  }
}
