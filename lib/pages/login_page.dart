import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  static final String routeName = '/login';
  final AuthProvider provider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: provider.loginWithGoogle,
            child: Text('Signin with Google'),
          )
        ],
      ),
    );
  }
}
