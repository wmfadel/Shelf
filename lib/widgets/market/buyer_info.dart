import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/pages/profile_page.dart';

class BuyerInfo extends StatelessWidget {
  final String buyerID;

  BuyerInfo({required this.buyerID});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(buyerID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();

        return ListTile(
          onTap: () => Navigator.of(context)
              .pushNamed(ProfilePage.routeName, arguments: buyerID),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              snapshot.data?.get('photo'),
            ),
          ),
          title: Text(snapshot.data?.get('name')),
          subtitle: Text(snapshot.data?.get('email')),
        );
      },
    );
  }
}
