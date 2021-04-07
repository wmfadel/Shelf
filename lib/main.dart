import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/add_book_page.dart';
import 'package:shelf/pages/book_page.dart';
import 'package:shelf/pages/create_shelf_screen.dart';
import 'package:shelf/pages/home_page.dart';
import 'package:shelf/pages/login_page.dart';
import 'package:shelf/pages/market_page.dart';
import 'package:shelf/pages/my_market_page.dart';
import 'package:shelf/pages/online_content_page.dart';
import 'package:shelf/pages/profile_page.dart';
import 'package:shelf/pages/rating_page.dart';
import 'package:shelf/pages/settings_page.dart';
import 'package:shelf/pages/shelf_page.dart';
import 'package:shelf/pages/wrapper.dart';
import 'package:shelf/providers/api_search_provider.dart';
import 'package:shelf/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthProvider _authProvider = AuthProvider();
  final APISearchPRovider _apiSearchPRovider = APISearchPRovider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _authProvider),
        ChangeNotifierProvider(create: (_) => _apiSearchPRovider),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
          iconTheme: IconThemeData(color: Colors.blue),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Wrapper.routeName,
        routes: {
          Wrapper.routeName: (BuildContext context) => Wrapper(),
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
          AddBookPage.routeName: (BuildContext context) => AddBookPage(),
          BookPage.routeName: (BuildContext context) => BookPage(),
          ProfilePage.routeName: (BuildContext context) => ProfilePage(),
          ShelfPage.routeName: (BuildContext context) => ShelfPage(),
          SettingsPage.routeName: (BuildContext context) => SettingsPage(),
          RatingPage.routeName: (BuildContext context) => RatingPage(),
          MarketPage.routeName: (BuildContext context) => MarketPage(),
          MyMarkeyPage.routeName: (BuildContext context) => MyMarkeyPage(),
          OnlineContentPage.routeName: (BuildContext context) =>
              OnlineContentPage(),
          CreateShelfScreen.routeName: (BuildContext context) =>
              CreateShelfScreen(),
        },
      ),
    );
  }
}
