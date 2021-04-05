import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RateWidget extends StatelessWidget {
  final String field;
  final String userID;
  final Color color;
  RateWidget(
      {required this.userID,
      required this.field,
      this.color = Colors.blueAccent});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : Text(
                snapshot.data?.get(field).toString() ?? '0',
                style: TextStyle(color: color, fontSize: 22),
              );
      },
    );
  }
}
