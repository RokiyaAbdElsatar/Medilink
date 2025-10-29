import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InputDecorator(
        isFocused: true,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Color(AppColor.primary),
            fontSize: 24,
          ),
          prefixIcon: Icon(
            widget.icon,
            color: Color(AppColor.primary),
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
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color(AppColor.primary),
              size: 20,
            ),
            style: const TextStyle(
              color: Color(AppColor.textHint),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            items: widget.items.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
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
    );
  }
}
