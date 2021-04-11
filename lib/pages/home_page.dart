import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/add_book_page.dart';
import 'package:shelf/pages/profile_page.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/custom_avatar.dart';
import 'package:shelf/widgets/custom_button.dart';
import 'package:shelf/widgets/drawer_list.dart';
import 'package:shelf/widgets/home_map.dart';
import 'package:shelf/widgets/market/book_overiew.dart';
import 'package:shelf/widgets/market/map_market.dart';

class HomePage extends StatelessWidget {
  static final String routeName = '/home';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
              iconData: Icons.library_books,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddBookPage.routeName),
            ),
          ),
          Positioned(
            top: 45,
            right: 135,
            child: CustomButton(
              iconData: Icons.search,
              onPressed: () {},
            ),
          ),
          Positioned(bottom: 1, child: MapMarket(context)),
          Positioned(bottom: 205, child: BookOverview()),
        ],
      ),
    );
  }
}
