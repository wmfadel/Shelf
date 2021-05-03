import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/widgets/profile_widgets/people_list_item.dart';

class FollowingList extends StatelessWidget {
  final QuerySnapshot data;
  FollowingList({required this.data});
  @override
  Widget build(BuildContext context) {
    return data.docs.length < 1
        ? Center(child: Text('Not Following anyone'))
        : ListView.builder(
            itemCount: data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var id = data.docs[index].id;
              return PeopleListItem(personID: id);
            },
          );
  }
}
