import 'package:cloud_firestore/cloud_firestore.dart';

class Medication {
  final String id;
  final String name;
  final String dosage;
  final String frequency;
  final String timeCategory; // Morning / Night
  final String time; // e.g. 9:00 AM
  final List<String> days;
  final Timestamp createdAt;
  final bool taken; // جديد

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.timeCategory,
    required this.time,
    required this.days,
    required this.createdAt,
    this.taken = false,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'dosage': dosage,
        'frequency': frequency,
        'timeCategory': timeCategory,
        'time': time,
        'days': days,
        'createdAt': createdAt,
        'taken': taken,
      };

  factory Medication.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Medication(
      id: doc.id,
      name: data['name'] ?? '',
      dosage: data['dosage'] ?? '',
      frequency: data['frequency'] ?? '',
      timeCategory: data['timeCategory'] ?? '',
      time: data['time'] ?? '',
      days: List<String>.from(data['days'] ?? []),
      createdAt: data['createdAt'] ?? Timestamp.now(),
      taken: data['taken'] ?? false,
    );
  }
}
