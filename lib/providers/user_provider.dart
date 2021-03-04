import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  bool? isVisible;

  getVisibility(String uid) {
    FirebaseFirestore.instance.doc('users/$uid').snapshots().listen((event) {
      isVisible = event.data()!['visibility'];
      notifyListeners();
    });
  }
}
