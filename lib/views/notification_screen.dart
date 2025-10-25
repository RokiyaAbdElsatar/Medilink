import 'package:flutter/material.dart';
import 'package:medilink/constant/appcolor.dart';
import 'package:medilink/models/notification_model.dart';
import 'package:medilink/widgets/notification_container.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool allSelected = true;
  bool unreadSelected = false;

  List<NotificationModel> notifications = [
    NotificationModel(
      mainText: "Medication Reminders",
      subText: "It’s time to take your Vitamin D (1000 IU)",
    ),
    NotificationModel(
      mainText: "Medication Reminders",
      subText: "Don’t forget your morning Metformin dose",
    ),
    NotificationModel(
      mainText: "Missed or Skipped Doses",
      subText: "You skipped your 8 AM Aspirin dose",
    ),
    NotificationModel(
      mainText: "Schedule or Plan Updates",
      subText: "New medication added: Amoxicillin 500 mg",
    ),
    NotificationModel(
      mainText: "Health and Checkup Reminders",
      subText: "Check your temperature before taking the next dose",
    ),
  ];

  List<NotificationModel> notificationsUnread = [
    NotificationModel(
      mainText: "Medication Reminders",
      subText: "It’s time to take your Vitamin D (1000 IU)",
    ),
    NotificationModel(
      mainText: "Medication Reminders",
      subText: "Don’t forget your morning Metformin dose",
    ),
    NotificationModel(
      mainText: "Missed or Skipped Doses",
      subText: "You skipped your 8 AM Aspirin dose",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                BackButton(color: Color(AppColor.primary)),
                Text(
                  "Notifications",
                  style: TextStyle(
                    color: Color(0xFF106B96),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: allSelected ? Color(AppColor.primary) : Colors.white,
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          allSelected = !allSelected;
                          unreadSelected = false;
                        });
                      },
                      child: Text(
                        "All",
                        style: TextStyle(
                          color: allSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: unreadSelected
                        ? Color(AppColor.primary)
                        : Colors.white,
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          unreadSelected = !unreadSelected;
                          allSelected = false;
                        });
                      },
                      child: Text(
                        "Unread",
                        style: TextStyle(
                          color: unreadSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Expanded(
              child: allSelected
                  ? ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationContainer(
                          mainText: notifications[index].mainText,
                          subText: notifications[index].subText,
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: notificationsUnread.length,
                      itemBuilder: (context, index) {
                        return NotificationContainer(
                          mainText: notificationsUnread[index].mainText,
                          subText: notificationsUnread[index].subText,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
