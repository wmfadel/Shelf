import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/add_book_page.dart';
import 'package:shelf/pages/profile_page.dart';
import 'package:shelf/pages/search_page.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/chat_provide.dart';
import 'package:shelf/providers/market_provider.dart';
import 'package:shelf/widgets/custom_avatar.dart';
import 'package:shelf/widgets/custom_button.dart';
import 'package:shelf/widgets/drawer_list.dart';
import 'package:shelf/widgets/home_map.dart';
import 'package:shelf/widgets/market/book_overiew.dart';
import 'package:shelf/widgets/market/map_market.dart';

class HomePage extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool chatsFetched = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!chatsFetched) {
      Provider.of<ChatProvider>(context, listen: false)
          .getUserChats(Provider.of<AuthProvider>(context, listen: false).uid!);
      chatsFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider = Provider.of<MarketProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerList(),
      body: Stack(
        children: [
          HomeMap(),
          Positioned(
            top: 45,
            left: 20,
            child: CustomButton(
              iconData: Icons.menu,
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
            ),
          ),
          Positioned(
            top: 45,
            right: 20,
            child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                    ProfilePage.routeName,
                    arguments:
                        Provider.of<AuthProvider>(context, listen: false).uid),
                child: CustomAvatar()),
          ),
          Positioned(
            top: 45,
            right: 80,
            child: CustomButton(
              iconData: Icons.add,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddBookPage.routeName),
            ),
          ),
          Positioned(
            top: 45,
            right: 140,
            child: CustomButton(
              iconData: Icons.search,
              onPressed: () =>
                  Navigator.of(context).pushNamed(SearchPage.routeName),
            ),
          ),
          if (marketProvider.searchBooks.isNotEmpty)
            Positioned(
              top: 45,
              right: 190,
              child: CustomButton(
                  iconData: Icons.search_off,
                  color: Colors.red,
                  onPressed: () => marketProvider.removeSearchResults()),
            ),
          Positioned(bottom: 1, child: MapMarket(context)),
          Positioned(bottom: 205, child: BookOverview()),
        ],
      ),
    );
  }
}
