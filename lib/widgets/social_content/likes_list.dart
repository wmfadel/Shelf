import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/widgets/social_content/user_info.dart';

class LikesList extends StatelessWidget {
  final List<String> likes;
  LikesList(this.likes);
  @override
  Widget build(BuildContext context) {
    if (likes.isEmpty)
      return Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('No one liked this post yet')]);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Users',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ...likes
              .map(
                (String likeID) => FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(likeID)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    return UserInfo(
                      userID: snapshot.data!.id,
                      name: snapshot.data?.get('name'),
                      email: snapshot.data?.get('email'),
                      photo: snapshot.data?.get('photo'),
                    );
                  },
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
