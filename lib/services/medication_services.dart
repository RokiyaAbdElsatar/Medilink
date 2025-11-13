import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_timezone_latest/flutter_native_timezone_latest.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/medication_model.dart';
import '../services/notification_helper.dart';

class MedicationService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _notifier = NotificationHelper();

  /// Helper: Get the collection reference for the logged-in user
  CollectionReference<Map<String, dynamic>> get _medCollection {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');
    return _firestore.collection('patients').doc(uid).collection('medications');
  }

  /// ✅ Ensure timezone is initialized before scheduling notifications
  Future<void> _ensureTimezoneInitialized() async {
    if (tz.local.name == 'UTC') {
      tz.initializeTimeZones();
      final String tzName =
          await FlutterNativeTimezoneLatest.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(tzName));
    }
  }

  /// ✅ Add new medication + schedule notifications
  Future<void> addMedication(Medication med) async {
    await _ensureTimezoneInitialized();

    // Create doc manually so we have a stable ID
    final docRef = _medCollection.doc();

    final medWithId = Medication(
      id: docRef.id,
      name: med.name,
      dosage: med.dosage,
      frequency: med.frequency,
      timeCategory: med.timeCategory,
      time: med.time,
      days: med.days,
      createdAt: med.createdAt,
    );

    await docRef.set(medWithId.toMap());

    // Schedule notification(s) after adding
    await _notifier.scheduleMedicationReminders(medWithId);
  }

  /// ✅ Update existing medication + reschedule notifications
  Future<void> updateMedication(Medication med) async {
    await _ensureTimezoneInitialized();

    if (med.id.isEmpty) {
      throw Exception('Medication ID is missing');
    }

    await _medCollection.doc(med.id).update(med.toMap());

    // Cancel old notifications & reschedule
    await _notifier.scheduleMedicationReminders(med);
  }

  /// ✅ Stream all medications for current user
  Stream<List<Medication>> getUserMedications() {
    return _medCollection
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Medication.fromDoc(d)).toList());
  }

  /// ✅ Delete medication + cancel any scheduled notifications
  Future<void> deleteMedication(String id) async {
    await _medCollection.doc(id).delete();
    await _notifier.cancelMedicationNotifications(id);
  }

  Future<void> markMedicationAsTaken(String medId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  await FirebaseFirestore.instance
      .collection('patients')
      .doc(user.uid)
      .collection('medications')
      .doc(medId)
      .update({'taken': true}); // أو العكس لو حابة toggle
}

}
