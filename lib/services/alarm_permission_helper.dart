import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<void> requestExactAlarmPermission(BuildContext context) async {
  if (!Platform.isAndroid) return;

  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  final sdkInt = androidInfo.version.sdkInt ?? 0;

  // Only Android 12 (API 31) and above use REQUEST_SCHEDULE_EXACT_ALARM
  if (sdkInt >= 31) {
    try {
      const intent = AndroidIntent(
        action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
      );
      await intent.launch();
    } catch (e) {
      debugPrint('⚠️ Could not open exact alarm settings: $e');

      // Fallback: open app settings instead
      const fallbackIntent = AndroidIntent(
        action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
      );
      await fallbackIntent.launch();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not open exact alarm settings. Please grant permissions manually.',
          ),
        ),
      );
    }
  } else {
    debugPrint("ℹ️ Exact alarm permission not required for SDK < 31");
  }
}
