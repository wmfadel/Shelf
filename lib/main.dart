import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shelf/pages/home_page.dart';
import 'package:shelf/pages/login_page.dart';
import 'package:shelf/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: HomePage.routeNAme,
      initialRoute: Wrapper.routeName,
      routes: {
        Wrapper.routeName: (BuildContext context) => Wrapper(),
        LoginPage.routeName: (BuildContext context) => LoginPage(),
        HomePage.routeNAme: (BuildContext context) => HomePage(),
      },
    );
  }
}

class Wrapper extends StatelessWidget {
  static final String routeName = '/';
  final AuthProvider provider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: provider.autoLogin(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.hasData && snapshot.data) {
          return HomePage();
        }
        print('user snapshot data: ${snapshot.data}');
        return LoginPage();
      },
    );
  }
}
