import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shelf/pages/home_page.dart';
import 'package:shelf/pages/login_page.dart';

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
      routes: {
        LoginPage.routeName: (BuildContext context) => LoginPage(),
        HomePage.routeNAme: (BuildContext context) => HomePage(),
      },
    );
  }
}
