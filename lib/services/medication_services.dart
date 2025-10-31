import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/medication_model.dart';

class MedicationService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// ✅ Helper getter to avoid repeating paths
  CollectionReference<Map<String, dynamic>> get _medCollection {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');
    return _firestore.collection('patients').doc(uid).collection('medications');
  }

  /// ✅ Add new medication
  Future<void> addMedication(Medication med) async {
    final docRef = _medCollection.doc(); // Create doc manually to get an ID
    await docRef.set({
      ...med.toMap(),
      'id': docRef.id, // Ensure the document stores its own ID
    });
  }

  /// ✅ Update existing medication
  Future<void> updateMedication(Medication med) async {
    if (med.id.isEmpty) {
      throw Exception('Medication ID is missing');
    }
    await _medCollection.doc(med.id).update(med.toMap());
  }

  /// ✅ Get all medications for current user
  Stream<List<Medication>> getUserMedications() {
    return _medCollection
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Medication.fromDoc(d)).toList());
  }

  /// ✅ Delete medication by ID
  Future<void> deleteMedication(String id) async {
    await _medCollection.doc(id).delete();
  }
}
