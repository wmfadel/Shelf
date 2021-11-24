import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/about_page.dart';
import 'package:shelf/pages/add_book_page.dart';
import 'package:shelf/pages/add_quote_page.dart';
import 'package:shelf/pages/book_page.dart';
import 'package:shelf/pages/chat_page.dart';
import 'package:shelf/pages/chat_room_page.dart';
import 'package:shelf/pages/contact_me_page.dart';
import 'package:shelf/pages/create_post_page.dart';
import 'package:shelf/pages/create_shelf_screen.dart';
import 'package:shelf/pages/help_page.dart';
import 'package:shelf/pages/home_page.dart';
import 'package:shelf/pages/image_uploader_page.dart';
import 'package:shelf/pages/login_page.dart';
import 'package:shelf/pages/market_page.dart';
import 'package:shelf/pages/my_market_page.dart';
import 'package:shelf/pages/on_boarding.dart';
import 'package:shelf/pages/online_content_page.dart';
import 'package:shelf/pages/profile_page.dart';
import 'package:shelf/pages/quotes_page.dart';
import 'package:shelf/pages/rating_page.dart';
import 'package:shelf/pages/search_page.dart';
import 'package:shelf/pages/settings_page.dart';
import 'package:shelf/pages/shelf_page.dart';
import 'package:shelf/pages/social_page.dart';
import 'package:shelf/pages/wrapper.dart';
import 'package:shelf/providers/analytics_provider.dart';
import 'package:shelf/providers/api_search_provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/chat_provide.dart';
import 'package:shelf/providers/map_provider.dart';
import 'package:shelf/providers/market_provider.dart';
import 'package:shelf/providers/post_provider.dart';
import 'package:shelf/providers/uploader_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthProvider _authProvider = AuthProvider();
  final APISearchPRovider _apiSearchPRovider = APISearchPRovider();
  final MapProvider _mapProvider = MapProvider();
  final MarketProvider _marketProvider = MarketProvider();
  final UploaderProvider _uploaderProvider = UploaderProvider();
  final PostProvider _postProvider = PostProvider();
  final ChatProvider _chatProvider = ChatProvider();
  final AnalyticsProvider _analyticsProvider = AnalyticsProvider();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _authProvider),
        ChangeNotifierProvider(create: (_) => _apiSearchPRovider),
        ChangeNotifierProvider(create: (_) => _mapProvider),
        ChangeNotifierProvider(create: (_) => _marketProvider),
        ChangeNotifierProvider(create: (_) => _uploaderProvider),
        ChangeNotifierProvider(create: (_) => _postProvider),
        ChangeNotifierProvider(create: (_) => _chatProvider),
        ChangeNotifierProvider(create: (_) => _analyticsProvider),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          iconTheme: IconThemeData(color: Colors.blue),
        ),
        debugShowCheckedModeBanner: false,
        navigatorObservers: <NavigatorObserver>[AnalyticsProvider.observer],
        initialRoute: Wrapper.routeName,
        routes: {
          Wrapper.routeName: (BuildContext context) => Wrapper(),
          OnBoardingPage.routeName: (BuildContext context) => OnBoardingPage(),
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
          AboutPage.routeName: (BuildContext context) => AboutPage(),
          SearchPage.routeName: (BuildContext context) => SearchPage(),
          AddBookPage.routeName: (BuildContext context) => AddBookPage(),
          BookPage.routeName: (BuildContext context) => BookPage(),
          ProfilePage.routeName: (BuildContext context) => ProfilePage(),
          ShelfPage.routeName: (BuildContext context) => ShelfPage(),
          SettingsPage.routeName: (BuildContext context) => SettingsPage(),
          HelpPage.routeName: (BuildContext context) => HelpPage(),
          ContactMePage.routeName: (BuildContext context) => ContactMePage(),
          RatingPage.routeName: (BuildContext context) => RatingPage(),
          MarketPage.routeName: (BuildContext context) => MarketPage(),
          MyMarkeyPage.routeName: (BuildContext context) => MyMarkeyPage(),
          ChatPage.routeName: (BuildContext context) => ChatPage(),
          ChatRoomPage.routeName: (BuildContext context) => ChatRoomPage(),
          QuotesPage.routeName: (BuildContext context) => QuotesPage(),
          AddQuotePage.routeName: (BuildContext context) => AddQuotePage(),
          SocialPage.routeName: (BuildContext context) => SocialPage(),
          CreatePostPage.routeName: (BuildContext context) => CreatePostPage(),
          ImageUploaderPage.routeName: (BuildContext context) =>
              ImageUploaderPage(),
          OnlineContentPage.routeName: (BuildContext context) =>
              OnlineContentPage(),
          CreateShelfScreen.routeName: (BuildContext context) =>
              CreateShelfScreen(),
        },
      ),
    );
  }
}
