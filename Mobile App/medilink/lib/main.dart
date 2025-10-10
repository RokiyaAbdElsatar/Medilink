import 'package:flutter/material.dart';
import 'package:medilink/login_screen.dart';
import 'package:medilink/views/chat_screen.dart';
import 'package:medilink/views/onboarding.dart';

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
      home: const OnboardingScreen(),
      routes: {
 '/login': (context) => const LoginScreen(),   
 '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
