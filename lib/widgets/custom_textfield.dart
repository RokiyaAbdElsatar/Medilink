import 'package:flutter/material.dart';

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
        cursorColor: const Color(0xff00AEEF),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: const TextStyle(color: Color(0xff00AEEF)),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff00AEEF), width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff00AEEF), width: 0.8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
