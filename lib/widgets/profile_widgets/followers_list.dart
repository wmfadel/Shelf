import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/widgets/profile_widgets/people_list_item.dart';

class FollowersList extends StatelessWidget {
  final QuerySnapshot data;
  FollowersList({required this.data});
  @override
  Widget build(BuildContext context) {
    return data.docs.length < 1
        ? Center(child: Text('No Followers'))
        : ListView.builder(
            itemCount: data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var id = data.docs[index].id;
              return PeopleListItem(personID: id);
            },
          );
  }
}
