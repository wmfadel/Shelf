import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class DrawerHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(
            Provider.of<AuthProvider>(context, listen: false).photo,
          ),
        ),
        SizedBox(height: 5),
        Text(
          Provider.of<AuthProvider>(context, listen: false).name,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          Provider.of<AuthProvider>(context, listen: false).email,
        ),
        SizedBox(height: 10),
        Divider(
          color: Colors.blue,
        ),
      ],
    );
  }
}
