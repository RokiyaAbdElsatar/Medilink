import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        cursorColor: Color(AppColor.primary),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: const TextStyle(
            color: Color(AppColor.primary),
            fontSize: 24,
          ),
          hintStyle: const TextStyle(
            color: Color(AppColor.textHint),
            fontSize: 13,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(AppColor.primary),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(AppColor.primary),
              width: 0.8,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
