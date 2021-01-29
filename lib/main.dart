import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/home_page.dart';
import 'package:shelf/pages/login_page.dart';
import 'package:shelf/pages/wrapper.dart';
import 'package:shelf/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthProvider _authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _authProvider),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Wrapper.routeName,
        debugShowCheckedModeBanner: false,
        routes: {
          Wrapper.routeName: (BuildContext context) => Wrapper(),
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}
