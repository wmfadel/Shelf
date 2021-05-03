import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/widgets/profile_widgets/people_handle.dart';

class ProfilePeopleView extends StatelessWidget {
  final String userID;
  ProfilePeopleView(this.userID);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFutures(),
      builder:
          (BuildContext context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator(strokeWidth: 2);
        return TextButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.blue),
                    title: Text(
                      'People',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    backgroundColor: Colors.white70,
                    centerTitle: true,
                  ),
                  body: PeopleHandle(data: snapshot.data!),
                ),
              )),
          child: Text(
            '${snapshot.data?[0].docs.length} followers • ${snapshot.data?[1].docs.length} following',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        );
      },
    );
  }

  Future<List<QuerySnapshot>> getFutures() async {
    return await Future.wait<QuerySnapshot>([
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('followers')
          .get(),
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('following')
          .get(),
    ]);
  }
}
