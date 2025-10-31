import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ✅ for responsive sizing (optional but recommended)

class CustomDropdownWithLabel extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final List<String> items;
  final String initialValue;
  final ValueChanged<String>? onChanged;

  const CustomDropdownWithLabel({
    super.key,
    required this.labelText,
    required this.icon,
    required this.items,
    required this.initialValue,
    this.onChanged,
  });

  @override
  State<CustomDropdownWithLabel> createState() =>
      _CustomDropdownWithLabelState();
}

class _CustomDropdownWithLabelState extends State<CustomDropdownWithLabel> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth - 36, // ✅ ensures it never overflows
        ),
        child: InputDecorator(
          isFocused: true,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: const Color(AppColor.primary),
              fontSize: 18, // ✅ reduced for better fit
              fontWeight: FontWeight.w600,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: const Color(AppColor.primary),
              size: 22,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(AppColor.primary)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(AppColor.primary)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(AppColor.primary),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true, // ✅ ensures text wraps correctly
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(AppColor.primary),
                size: 24,
              ),
              style: const TextStyle(
                color: Color(AppColor.textHint),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              items: widget.items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis, // ✅ no overflow text
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedValue = newValue;
                  });
                  widget.onChanged?.call(newValue);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
