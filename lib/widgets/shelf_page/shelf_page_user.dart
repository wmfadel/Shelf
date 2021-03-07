import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/widgets/shelf_page/shmr/shmr_shelf_page_user.dart';

class ShelfPageUser extends StatelessWidget {
  final String userID;

  ShelfPageUser(this.userID);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return ShmrShelfPageUser();
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data?.get('photo')),
            ),
            SizedBox(width: 5),
            Text(
              snapshot.data?.get('name'),
              style: TextStyle(fontSize: 18),
            )
          ],
        );
      },
    );
  }
}
