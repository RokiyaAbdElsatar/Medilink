import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? errorText; // ✅ optional validation message

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text, // ✅ default safe type
    this.errorText, // ✅ optional, shows only if provided
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        cursorColor: Color(AppColor.primary),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: errorText, // ✅ shows red error message if any
          labelStyle: const TextStyle(
            color: Color(AppColor.primary),
            fontSize: 16,
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
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
