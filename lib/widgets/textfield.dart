import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Textfield extends StatelessWidget {
  Textfield({super.key, required this.labletitle, required this.hinttitle});
  String? labletitle;
  String? hinttitle;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Color(0xFF262626),
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(color: Color(0xFF8C7D7D)),
        labelText: labletitle,
        hintText: hinttitle,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
