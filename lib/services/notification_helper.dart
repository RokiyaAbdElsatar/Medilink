import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import 'package:medilink/models/medication_model.dart';

class NotificationHelper {
  static final NotificationHelper _instance = NotificationHelper._internal();
  factory NotificationHelper() => _instance;
  NotificationHelper._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // 🔹 Initialize notifications
  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final settings = InitializationSettings(android: android, iOS: ios);
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (_) {},
    );

    // Request iOS permissions
    await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  // 🔹 Notification channel & appearance
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

  // 🔹 Helper to create unique IDs
  int _notificationId(String medId, [int suffix = 0]) =>
      medId.hashCode.abs() + suffix;

  // 🔹 Parse a "12:30 PM" string into today's DateTime
  DateTime _timeStringToTodayDate(String timeStr) {
    final f = DateFormat('h:mm a');
    final parsed = f.parse(timeStr);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, parsed.hour, parsed.minute);
  }

  // 🔹 Compute the next valid time (today or tomorrow)
  tz.TZDateTime _nextInstanceForTime(DateTime timeToday) {
    final tzNow = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      tzNow.year,
      tzNow.month,
      tzNow.day,
      timeToday.hour,
      timeToday.minute,
    );
    if (scheduled.isBefore(tzNow)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    print('📅 One-time reminder scheduled for: ${scheduled.toLocal()}');
    return scheduled;
  }

  // 🔹 Schedule a one-time reminder
  Future<void> scheduleNextReminder(Medication med) async {
    final timeToday = _timeStringToTodayDate(med.time);
    final scheduled = _nextInstanceForTime(timeToday);

    await _plugin.zonedSchedule(
      _notificationId(med.id),
      'Time for ${med.name}',
      '${med.dosage} • ${med.frequency}',
      scheduled,
      _details(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: med.id,
    );

    print('✅ One-time notification scheduled for ${scheduled.toLocal()}');
  }

  // 🔹 Schedule weekly reminders
  Future<void> scheduleWeeklyReminders(Medication med) async {
    if (med.days.isEmpty) return scheduleNextReminder(med);

    final wk = {
      'Mon': DateTime.monday,
      'Tue': DateTime.tuesday,
      'Wed': DateTime.wednesday,
      'Thu': DateTime.thursday,
      'Fri': DateTime.friday,
      'Sat': DateTime.saturday,
      'Sun': DateTime.sunday,
      'Monday': DateTime.monday,
      'Tuesday': DateTime.tuesday,
      'Wednesday': DateTime.wednesday,
      'Thursday': DateTime.thursday,
      'Friday': DateTime.friday,
      'Saturday': DateTime.saturday,
      'Sunday': DateTime.sunday,
    };

    final timeToday = _timeStringToTodayDate(med.time);
    int suffix = 0;

    for (final day in med.days) {
      final weekday = wk[day];
      if (weekday == null) continue;

      final scheduled = _nextInstanceForWeekday(timeToday, weekday);
      final id = _notificationId(med.id, suffix);

      await _plugin.zonedSchedule(
        id,
        'Time for ${med.name}',
        '${med.dosage} • ${med.frequency}',
        scheduled,
        _details(),
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: med.id,
      );

      print(
        '📅 Scheduled ${med.name} for $day at ${scheduled.toLocal()} (id: $id)',
      );
      suffix++;
    }
  }

  // 🔹 Calculate the next weekday occurrence
  tz.TZDateTime _nextInstanceForWeekday(DateTime timeToday, int weekday) {
    final tzNow = tz.TZDateTime.now(tz.local);

    var scheduled = tz.TZDateTime(
      tz.local,
      tzNow.year,
      tzNow.month,
      tzNow.day,
      timeToday.hour,
      timeToday.minute,
    );

    int daysToAdd = (weekday - tzNow.weekday) % 7;

    // ✅ If today and time already passed, schedule next week
    if (daysToAdd == 0 && scheduled.isBefore(tzNow)) {
      daysToAdd = 7;
    }

    scheduled = scheduled.add(Duration(days: daysToAdd));

    print('🕓 Next instance for weekday=$weekday is ${scheduled.toLocal()}');
    return scheduled;
  }

  // 🔹 Cancel all reminders for a medication
  Future<void> cancelMedicationNotifications(String medId) async {
    for (int suffix = 0; suffix < 8; suffix++) {
      await _plugin.cancel(_notificationId(medId, suffix));
    }
  }

  // 🔹 Entry point: schedule depending on days list
  Future<void> scheduleMedicationReminders(Medication med) async {
    await cancelMedicationNotifications(med.id);
    if (med.days.isNotEmpty) {
      await scheduleWeeklyReminders(med);
    } else {
      await scheduleNextReminder(med);
    }
  }
}
