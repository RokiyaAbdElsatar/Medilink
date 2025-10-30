import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class PersonalInfoContainer extends StatelessWidget {
  const PersonalInfoContainer({
    super.key,
    required this.email,
    required this.phone,
    required this.address,
    required this.language,
    required this.onEdit,
  });
  final String email;
  final String phone;
  final String address;
  final String language;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          color: Color(0xFF106B96),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(AppColor.background),
                        ),
                        child: IconButton(
                          onPressed: onEdit,
                          icon: Icon(
                            Icons.edit_square,
                            color: Color(AppColor.primary),
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.mail_outline,
                              color: Color(AppColor.primary),
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text("$email"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              color: Color(AppColor.primary),
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text("$phone"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.pin_drop_outlined,
                              color: Color(AppColor.primary),
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text("$address"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.language,
                              color: Color(AppColor.primary),
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text("$language"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
