import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain_models/domain_models.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Handles reading and updating the user's profile in Firebase FireStore.
class FirebaseUserStore {
  FirebaseUserStore({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<AppUser?> fetchRemoteUser({required User authUser}) async {
    DocumentSnapshot user =
        await _firestore.collection('users').doc(authUser.uid).get();

    if (!user.exists) return null;
    return AppUser.fromJson(user.data() as Map<String, dynamic>);
  }

  Future<void> createRemoteUser({required AppUser user}) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }
}
