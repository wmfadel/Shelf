import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/home_page.dart';
import 'package:shelf/pages/login_page.dart';
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
    if (isLogged != null && isLogged) {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
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
