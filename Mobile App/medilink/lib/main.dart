import 'dart:math';

import 'package:flutter/material.dart';
import 'package:medilink/screens/login_screen.dart';
import 'package:medilink/screens/medications_screen.dart';
import 'package:medilink/screens/medication_detail_screen.dart';

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

      home: MedicationsScreen(),
    );
  }
}
