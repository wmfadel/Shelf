import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class CustomAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(50),
      color: Colors.blue,
      child: Container(
        width: 45,
        height: 45,
        child: Center(
            child: CircleAvatar(
          backgroundImage: NetworkImage(_authProvider.photo!),
        )),
      ),
    );
  }
}
