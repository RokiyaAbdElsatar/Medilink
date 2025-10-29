import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'day_chip.dart';

class ScheduleSection extends StatefulWidget {
  const ScheduleSection({super.key});

  @override
  State<ScheduleSection> createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends State<ScheduleSection> {
  final List<String> _days = [
    'Sat',
    'Sun',
    'Mon',
    'Tues',
    'Wed',
    'Thurs',
    'Fri',
  ];
  final Map<String, bool> _selectedDays = {
    'Sat': false,
    'Sun': false,
    'Mon': false,
    'Tues': false,
    'Wed': false,
    'Thurs': false,
    'Fri': false,
  };

  void _selectAllDays() {
    bool allSelected = _selectedDays.values.every((selected) => selected);
    setState(() {
      for (var day in _days) {
        _selectedDays[day] = !allSelected;
      }
    });
  }

  void _toggleDay(String day) {
    setState(() {
      _selectedDays[day] = !_selectedDays[day]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Days Of Week',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(AppColor.medicationColor),
                ),
              ),
              TextButton(
                onPressed: _selectAllDays,
                child: const Text(
                  'Select All',
                  style: TextStyle(
                    color: Color(AppColor.primary),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _days.map((day) {
              return DayChip(
                day: day,
                isSelected: _selectedDays[day]!,
                onTap: () => _toggleDay(day),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
