import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/home_page.dart';
import 'package:shelf/pages/login_page.dart';
import 'package:shelf/pages/on_boarding.dart';
import 'package:shelf/providers/auth_provider.dart';

class Wrapper extends StatefulWidget {
  static final String routeName = '/';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    handleAutoLogin();
  }

  handleAutoLogin() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool isLogged =
        await Provider.of<AuthProvider>(context, listen: false).autoLogin();
    print('wrapper log state $isLogged');
    if (isLogged) {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } else {
      // check for onboarding page
      bool onBoarding = await Provider.of<AuthProvider>(context, listen: false)
          .checkOnborading();

      if (onBoarding) {
        // if true means its already Shown
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      } else {
        // else not shown must be displayed
        // in there fter finishing navigate to home page
        // and mark it as shown for the future
        Navigator.of(context).pushReplacementNamed(OnBoardingPage.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
