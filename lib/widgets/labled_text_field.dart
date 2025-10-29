import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class LabeledTextField extends StatelessWidget {
  final String labelText;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool isPassword;
  const LabeledTextField({
    super.key,
    required this.labelText,
    required this.hint,
    required this.icon,
    this.controller,
    this.isPassword = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(color: Color(AppColor.primary), fontSize: 24),
          hintText: hint,
          hintStyle: TextStyle(color: Color(AppColor.textHint)),
          prefixIcon: Icon(icon, color: Color(AppColor.primary)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(AppColor.primary)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(AppColor.primary)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(AppColor.primary), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
