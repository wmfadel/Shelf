import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/widgets/profile_widgets/shmr_people_list_item.dart';

class PeopleListItem extends StatelessWidget {
  final String personID;

  PeopleListItem({required this.personID});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('users').doc(personID).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return ShmrPeopleListItem();
        return ListTile(
          title: Text(snapshot.data?.get('name')),
          subtitle: Text(snapshot.data?.get('email')),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(snapshot.data?.get('photo')),
          ),
        );
      },
    );
  }
}
