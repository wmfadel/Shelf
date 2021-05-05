import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/pages/profile_page.dart';
import 'package:shelf/widgets/social_content/shmr/shmr_user_info.dart';

class UserInfo extends StatelessWidget {
  final String userID;
  const UserInfo({
    required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return ShmrUserInfo();
        return GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProfilePage.routeName, arguments: userID),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data?.get('photo')),
              ),
              SizedBox(width: 4),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data?.get('name'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    snapshot.data?.get('email'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
