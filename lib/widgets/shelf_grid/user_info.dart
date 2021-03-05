import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/widgets/shimmer_items/shmr_shelf_item_user.dart';

class UserInfo extends StatelessWidget {
  final String userID;
  UserInfo({required this.userID});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(userID).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return ShmrShelfItemUser();
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(snapshot.data!.get('photo')),
              ),
              SizedBox(width: 4),
              Text(
                snapshot.data!.get('name'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          );
        });
  }
}
