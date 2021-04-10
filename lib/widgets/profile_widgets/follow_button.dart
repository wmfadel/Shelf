import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class FollowButton extends StatefulWidget {
  final String profileID;
  FollowButton(this.profileID);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    final String currentUSerID =
        Provider.of<AuthProvider>(context, listen: false).uid!;
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUSerID)
            .collection('following')
            .doc(widget.profileID)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container();
          bool? isFollowing = false;
          if (snapshot.data?.exists != null) {
            isFollowing = snapshot.data?.exists;
          }

          return FloatingActionButton(
            onPressed: () {
              if (isFollowing!) {
                // unfollow
                unfollow(currentUSerID);
                setState(() {
                  isFollowing = true;
                });
              } else {
                //follow
                followUser(currentUSerID);
                setState(() {
                  isFollowing = true;
                });
              }
            },
            backgroundColor:
                isFollowing! ? Colors.red : Theme.of(context).primaryColor,
            child: Icon(
              isFollowing! ? Icons.person_remove_alt_1 : Icons.person_add_alt,
            ),
          );
        });
  }

  unfollow(currentUSerID) {
    // remove current user following list
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUSerID)
        .collection('following')
        .doc(widget.profileID)
        .delete();
    // remove from profile user followers list
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.profileID)
        .collection('followers')
        .doc(currentUSerID)
        .delete();
  }

  followUser(currentUSerID) {
    // add to current user following list
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUSerID)
        .collection('following')
        .doc(widget.profileID)
        .set({
      'follow-date': Timestamp.now(),
    });
    // add to profile user followers list
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.profileID)
        .collection('followers')
        .doc(currentUSerID)
        .set({
      'follow-date': Timestamp.now(),
    });
  }
}
