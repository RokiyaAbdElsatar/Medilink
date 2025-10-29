import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class DetailsSection extends StatefulWidget {
  final String frequency;
  final String time;
  final String startDate;

  const DetailsSection({
    super.key,
    required this.frequency,
    required this.time,
    required this.startDate,
  });

  @override
  State<DetailsSection> createState() => _DetailsSectionState();
}

class _DetailsSectionState extends State<DetailsSection> {
  late String frequency;
  late String time;
  late String startDate;

  @override
  void initState() {
    super.initState();
    frequency = widget.frequency;
    time = widget.time;
    startDate = widget.startDate;
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(AppColor.textHint),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(AppColor.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateDetails({
    String? newFrequency,
    String? newTime,
    String? newStartDate,
  }) {
    setState(() {
      if (newFrequency != null) frequency = newFrequency;
      if (newTime != null) time = newTime;
      if (newStartDate != null) startDate = newStartDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(AppColor.textSecondary),
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
            'Details',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(AppColor.medicationColor),
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailItem('Frequency', frequency),
          _buildDetailItem('Time', time),
          _buildDetailItem('Start Date', startDate),
        ],
      ),
    );
  }
}
