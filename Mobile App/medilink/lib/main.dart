import 'package:flutter/material.dart';
import 'package:medilink/views/Doctor%20Mode/onboarding1.dart';
import 'package:medilink/views/Pharmacies.dart';

import 'views/Hospitals.dart' show Hospitals;

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

      home:Pharmacies(),
    );
  }
}
