import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/pics/book_lover.png'),
          Text(
            'Shelf.',
            style: GoogleFonts.pacifico(
              fontSize: 64,
              color: Colors.blue,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            'everything there is to do with books',
            style: GoogleFonts.pacifico(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLogging
                ? null
                : () async {
                    setState(() {
                      isLogging = true;
                    });
                    bool logStatus;

                    logStatus =
                        await Provider.of<AuthProvider>(context, listen: false)
                            .loginWithGoogle();

                    if (logStatus != null && logStatus) {
                      //User is logged in navigate to home screen
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/pics/google_logo.png',
                  width: 32,
                ),
                SizedBox(width: 8),
                Text('Continue with Google'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
