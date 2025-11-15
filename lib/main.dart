import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medilink/firebase_options.dart';
import 'package:medilink/services/notification_helper.dart';
import 'package:medilink/views/login_screen.dart';
import 'package:medilink/views/chat_screen.dart';
import 'package:medilink/views/profile_screen.dart';
import 'package:medilink/views/splash_screen.dart';
import 'package:flutter_native_timezone_latest/flutter_native_timezone_latest.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  tz.initializeTimeZones();
  final String tzName = await FlutterNativeTimezoneLatest.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(tzName));

  final now = DateTime.now();
  final tzNow = tz.TZDateTime.now(tz.local);
  print('🕓 System time: $now');
  print('🌍 TZ time: $tzNow (${tz.local.name})');

  await NotificationHelper().init();

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
      builder: (_, __) => MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey, // ✅ important
        debugShowCheckedModeBanner: false,
        title: 'Medilink',

        home: const SplashScreen(),

        routes: {
          '/login': (context) => const LoginScreen(),
          '/chat': (context) => const ChatScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
