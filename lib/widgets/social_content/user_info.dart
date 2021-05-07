import 'package:flutter/material.dart';
import 'package:shelf/pages/profile_page.dart';

class UserInfo extends StatelessWidget {
  final String userID;
  final String name;
  final String email;
  final String photo;
  const UserInfo(
      {required this.userID,
      required this.name,
      required this.email,
      required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(ProfilePage.routeName, arguments: userID),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(photo),
          ),
          SizedBox(width: 4),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                email,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
