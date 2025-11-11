class NotificationModel {
  final String mainText;
  final String subText;
   bool isRead;

  NotificationModel({
    required this.mainText,
    required this.subText,
    this.isRead = false,
  });

  // 🟢 دالة copyWith لتعديل القيم بسهولة
  NotificationModel copyWith({
    String? mainText,
    String? subText,
    bool? isRead,
  }) {
    return NotificationModel(
      mainText: mainText ?? this.mainText,
      subText: subText ?? this.subText,
      isRead: isRead ?? this.isRead,
    );
  }
}
