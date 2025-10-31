import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class ScheduleSection extends StatefulWidget {
  final List<String> selectedDays;
  final ValueChanged<List<String>>? onDaysChanged;

  const ScheduleSection({
    super.key,
    required this.selectedDays,
    this.onDaysChanged,
  });

  @override
  State<ScheduleSection> createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends State<ScheduleSection> {
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  late List<String> _selectedDays;

  @override
  void initState() {
    super.initState();
    _selectedDays = List<String>.from(widget.selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(AppColor.primary).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Schedule',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(AppColor.medicationColor),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _days.map((day) {
              final isSelected = _selectedDays.contains(day);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedDays.remove(day);
                    } else {
                      _selectedDays.add(day);
                    }
                  });
                  widget.onDaysChanged?.call(_selectedDays);
                },
                child: _buildDayChip(day, isSelected),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDayChip(String day, bool isSelected) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected
            ? Color(AppColor.primary).withOpacity(0.1)
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(AppColor.primary), width: 2),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            color: isSelected
                ? Color(AppColor.medicationColor)
                : Colors.grey[600]!,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
