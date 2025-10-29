import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> registerUser({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    try {
      // Create user account
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Store user data in Firestore
      await _firestore
          .collection('patients')
          .doc(userCredential.user!.uid)
          .set({
            ...userData,
            'uid': userCredential.user!.uid,
            'createdAt': FieldValue.serverTimestamp(),
          });

      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
