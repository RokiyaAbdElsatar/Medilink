import 'package:flutter/cupertino.dart';
import 'package:medilink/constant/appcolor.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    super.key,
    required this.mainText,
    required this.subText,
  });

  final String mainText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(AppColor.backGroundColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainText,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(subText, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
