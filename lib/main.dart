import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medilink/firebase_options.dart';
import 'package:medilink/views/login_screen.dart';
import 'package:medilink/views/chat_screen.dart';
import 'package:medilink/views/medication_screen.dart';
import 'package:medilink/views/navigation_screen.dart';
import 'package:medilink/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MedilinkApp());
}

class MedilinkApp extends StatelessWidget {
  const MedilinkApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medilink',

        //home: NavigationScreen(),
        home: SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/chat': (context) => const ChatScreen(),
        },
  
      ),
    );
  }
}
