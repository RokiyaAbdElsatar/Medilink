import 'package:flutter/material.dart';
import 'package:medilink/views/Doctor%20Mode/doc_working_hours.dart';

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

      home: DocWorkingHours(),
    );
  }
}
