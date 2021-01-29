import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/home_page.dart';
import 'package:shelf/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogging = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: isLogging
                ? null
                : () async {
                    setState(() {
                      isLogging = true;
                    });
                    bool logStatus =
                        await Provider.of<AuthProvider>(context, listen: false)
                            .loginWithGoogle();
                    if (logStatus) {
                      Navigator.of(context)
                          .pushReplacementNamed(HomePage.routeName);
                    } else {
                      // show some error dialog
                      setState(() {
                        isLogging = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to Login'),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                  },
            child: Text('Signin with Google'),
          )
        ],
      ),
    );
  }
}
