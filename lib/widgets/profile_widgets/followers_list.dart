import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/widgets/profile_widgets/people_list_item.dart';

class FollowersList extends StatelessWidget {
  final String uid;
  FollowersList({required this.uid});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('followers')
          .get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        var count = snapshot.data?.docs.length;
        return count! < 1
            ? Center(child: Text('No Followers'))
            : ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  var id = snapshot.data?.docs[index].id;
                  return PeopleListItem(personID: id!);
                },
              );
      },
    );
  }
}
