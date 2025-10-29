import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int currentStep;

  const ProgressBar({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: currentStep == 0 ? Colors.white : Colors.white70,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: currentStep == 1 ? Colors.white : Colors.white70,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
