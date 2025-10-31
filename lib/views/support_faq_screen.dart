import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class SupportFAQScreen extends StatelessWidget {
  const SupportFAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'question': 'How do I add a new medication?',
        'answer':
            'Go to the Medications tab and tap the “+” button at the bottom right. Fill in the medicine name, dosage, and schedule, then save.',
      },
      {
        'question': 'Can I edit or delete a medication?',
        'answer':
            'Yes. From the Medications screen, tap the edit or delete icons on any medication card to update or remove it.',
      },
      {
        'question': 'What does the schedule section do?',
        'answer':
            'The schedule section allows you to choose the frequency, time category (Morning/Night), and specific days for each medication. This ensures reminders are set properly.',
      },
      {
        'question': 'Is my data safe?',
        'answer':
            'Absolutely. All your data is securely stored in Firebase and linked only to your personal account. We never share or expose your information.',
      },
      {
        'question': 'I forgot my password. What should I do?',
        'answer':
            'On the login screen, tap “Forgot Password?” and follow the instructions to reset it through your registered email address.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Support & FAQ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(AppColor.primary),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(AppColor.textSecondary),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final item = faqs[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text(
                item['question']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppColor.medicationColor),
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    item['answer']!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(AppColor.textHint),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
