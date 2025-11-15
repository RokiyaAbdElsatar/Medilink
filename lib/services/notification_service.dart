import 'package:medilink/models/notification_model.dart';

class InAppNotificationService {
  static final InAppNotificationService _instance =
      InAppNotificationService._internal();
  factory InAppNotificationService() => _instance;
  InAppNotificationService._internal();

  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications.reversed.toList();

 void addNotification(NotificationModel notification) {
  final alreadyExists = _notifications.any((n) =>
      n.mainText == notification.mainText &&
      n.subText == notification.subText);

  if (!alreadyExists) {
    _notifications.add(notification);
  }
}


  void clearNotifications() {
    _notifications.clear();
  }

  // ✅ تعليم الكل كمقروء
  void markAllAsRead() {
    for (var n in _notifications) {
      n.isRead = true;
    }
  }

  // ✅ تعليم واحد كمقروء
void markAsRead(NotificationModel notification) {
  final index = _notifications.indexOf(notification);
  if (index != -1) {
    _notifications[index] = notification.copyWith(isRead: true);
  }
}



  // ✅ جلب الغير مقروء فقط
  List<NotificationModel> get unreadNotifications =>
      _notifications.where((n) => !n.isRead).toList().reversed.toList();
}
