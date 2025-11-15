import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /// Add new booking
  Future<void> addBooking({
    required Map<String, dynamic> hospital,
    required Map<String, dynamic> service,
    required DateTime date,
    required String time,
    required String address,
    required String phone,
    required String paymentMethod,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final bookingData = {
      'userId': user.uid,
      'hospital': hospital,
      'service': service,
      'date': Timestamp.fromDate(date),
      'time': time,
      'address': address,
      'phone': phone,
      'paymentMethod': paymentMethod,
      'status': 'pending', // ✅ default status
      'createdAt': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('services').add(bookingData);
  }

  /// Update booking status (for admin)
  Future<void> updateBookingStatus({
    required String bookingId,
    required String newStatus, // "accepted" or "rejected"
  }) async {
    await _firestore.collection('services').doc(bookingId).update({
      'status': newStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getAllBookings() {
    return _firestore
        .collection('services')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getUserBookings() {
    final user = _auth.currentUser;
    if (user == null) {
      // return an empty stream or throw depending on your flow
      return const Stream.empty();
    }
    return _firestore
        .collection('services')
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
