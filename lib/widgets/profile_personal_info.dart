import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePersonalInfo extends StatelessWidget {
  final DocumentSnapshot data;
  const ProfilePersonalInfo({@required this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
        ),
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(
            data.get('photo'),
          ),
        ),
        SizedBox(height: 5),
        Text(
          data.get('name'),
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data.get('email'),
        ),
      ],
    );
  }
}
