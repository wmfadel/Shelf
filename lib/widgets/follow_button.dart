import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class FollowButton extends StatelessWidget {
  final String profileID;
  FollowButton(this.profileID);
  @override
  Widget build(BuildContext context) {
    final String currentUSerID =
        Provider.of<AuthProvider>(context, listen: false).uid!;
    return FloatingActionButton(
      onPressed: () {
        // add to current user following list
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUSerID)
            .collection('following')
            .doc(profileID)
            .set({
          'follow-date': DateTime.now(),
        });
        // add to profile user followers list
        FirebaseFirestore.instance
            .collection('users')
            .doc(profileID)
            .collection('followers')
            .doc(currentUSerID)
            .set({
          'follow-date': DateTime.now(),
        });
      },
      child: Icon(Icons.person_add_alt),
    );
  }
}
