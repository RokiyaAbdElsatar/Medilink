import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/models/notification_model.dart';
import 'package:medilink/services/notification_service.dart';
import 'package:medilink/widgets/notification_container.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool allSelected = true;
  bool unreadSelected = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = InAppNotificationService();
    final List<NotificationModel> notifications =
        allSelected ? service.notifications : service.unreadNotifications;

    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                BackButton(color: Color(AppColor.primary)),
                const Text(
                  "Notifications",
                  style: TextStyle(
                    color: Color(0xFF106B96),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                // ✅ زرار "Mark all as read"
                TextButton(
                  onPressed: () {
                    setState(() {
                      service.markAllAsRead();
                    });
                  },
                  child: const Text(
                    "Mark all as read",
                    style: TextStyle(
                      color: Color(0xFF106B96),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildFilterButton("All", allSelected, () {
                  setState(() {
                    allSelected = true;
                    unreadSelected = false;
                  });
                }),
                const SizedBox(width: 20),
                _buildFilterButton("Unread", unreadSelected, () {
                  setState(() {
                    unreadSelected = true;
                    allSelected = false;
                  });
                }),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            Expanded(
              child: notifications.isEmpty
                  ? const Center(
                      child: Text(
                        "No notifications yet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notif = notifications[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              notif.isRead = true;
                            });
                          },
                          child: Opacity(
                            opacity: notif.isRead ? 0.5 : 1,
                            child: NotificationContainer(
                              mainText: notif.mainText,
                              subText: notif.subText,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, bool selected, VoidCallback onPressed) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selected ? Color(AppColor.primary) : Colors.white,
      ),
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
