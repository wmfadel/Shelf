import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/home_page.dart';
import 'package:shelf/pages/login_page.dart';
import 'package:shelf/providers/auth_provider.dart';

class OnBoardingPage extends StatelessWidget {
  static final String routeName = 'OnBoarding_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .completedOnBoarding();
              Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
            },
            child: Text('Done')),
      ),
    );
  }
}
