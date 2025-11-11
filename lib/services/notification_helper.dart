import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:medilink/models/medication_model.dart';
import 'package:medilink/models/notification_model.dart';
import 'package:medilink/services/notification_service.dart';

class NotificationHelper {
  static final NotificationHelper _instance = NotificationHelper._internal();
  factory NotificationHelper() => _instance;
  NotificationHelper._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);
    await _plugin.initialize(settings);
  }

  NotificationDetails _details() {
    const android = AndroidNotificationDetails(
      'med_channel_id',
      'Medication Reminders',
      channelDescription: 'Reminders to take medications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const ios = DarwinNotificationDetails();
    return const NotificationDetails(android: android, iOS: ios);
  }

  int _notificationId(String medId, [int suffix = 0]) =>
      medId.hashCode.abs() + suffix;

  DateTime _timeStringToTodayDate(String timeStr) {
    final f = DateFormat('h:mm a');
    final parsed = f.parse(timeStr);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, parsed.hour, parsed.minute);
  }

  Duration _delayUntil(DateTime targetTime) {
    final now = DateTime.now();
    var diff = targetTime.difference(now);
    if (diff.isNegative) diff += const Duration(days: 1);
    return diff;
  }

  Future<void> _sendNotificationNow(Medication med, int id) async {
    await _plugin.show(
      id,
      'Time for ${med.name}',
      '${med.dosage} • ${med.frequency}',
      _details(),
      payload: med.id,
    );

    // ✅ Save inside app only once
    InAppNotificationService().addNotification(
      NotificationModel(
        mainText: 'Time for ${med.name}',
        subText: '${med.dosage} • ${med.frequency}',
      ),
    );

    print('💊 Notification triggered for ${med.name}');
  }

  // 🔹 One-time reminder
  Future<void> scheduleNextReminder(Medication med) async {
    final timeToday = _timeStringToTodayDate(med.time);
    final delay = _delayUntil(timeToday);
    final id = _notificationId(med.id);

    print('🕓 Scheduling ${med.name} in ${delay.inMinutes} min.');
    Future.delayed(delay, () => _sendNotificationNow(med, id));
  }

  // 🔹 Weekly reminders
  Future<void> scheduleWeeklyReminders(Medication med) async {
    if (med.days.isEmpty) {
      await scheduleNextReminder(med);
      return;
    }

    final wk = {
      'Mon': DateTime.monday,
      'Tue': DateTime.tuesday,
      'Wed': DateTime.wednesday,
      'Thu': DateTime.thursday,
      'Fri': DateTime.friday,
      'Sat': DateTime.saturday,
      'Sun': DateTime.sunday,
    };

    final now = DateTime.now();
    final timeToday = _timeStringToTodayDate(med.time);
    int suffix = 0;

    for (final day in med.days) {
      final weekday = wk[day];
      if (weekday == null) continue;

      final nextDate = _nextInstanceForWeekday(timeToday, weekday);
      final delay = nextDate.difference(now);
      final id = _notificationId(med.id, suffix);

      print('📅 Scheduling ${med.name} for $day in ${delay.inMinutes} min.');

      Future.delayed(delay, () async {
        await _sendNotificationNow(med, id);
        // إعادة التذكير الأسبوعي كل 7 أيام
        Timer.periodic(const Duration(days: 7), (_) async {
          await _sendNotificationNow(med, id);
        });
      });

      suffix++;
    }
  }

  DateTime _nextInstanceForWeekday(DateTime timeToday, int weekday) {
    final now = DateTime.now();
    var scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      timeToday.hour,
      timeToday.minute,
    );

    int daysToAdd = (weekday - now.weekday) % 7;
    if (daysToAdd == 0 && scheduled.isBefore(now)) daysToAdd = 7;
    return scheduled.add(Duration(days: daysToAdd));
  }

  Future<void> cancelMedicationNotifications(String medId) async {
    for (int suffix = 0; suffix < 8; suffix++) {
      await _plugin.cancel(_notificationId(medId, suffix));
    }
  }

  Future<void> scheduleMedicationReminders(Medication med) async {
    await cancelMedicationNotifications(med.id);
    if (med.days.isEmpty) {
      await scheduleNextReminder(med);
    } else {
      await scheduleWeeklyReminders(med);
    }
  }
}
