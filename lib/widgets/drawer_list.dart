import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/chat_page.dart';
import 'package:shelf/pages/login_page.dart';
import 'package:shelf/pages/market_page.dart';
import 'package:shelf/pages/my_market_page.dart';
import 'package:shelf/pages/online_content_page.dart';
import 'package:shelf/pages/quotes_page.dart';
import 'package:shelf/pages/rating_page.dart';
import 'package:shelf/pages/settings_page.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/map_provider.dart';
import 'package:shelf/widgets/drawer_heading.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawerHeading(),
            ListTile(
                title: Text('Market'),
                leading: Icon(
                  Icons.store_mall_directory,
                  color: Colors.green,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(MarketPage.routeName);
                }),
            ListTile(
                title: Text('My Market'),
                leading: Icon(
                  Icons.storefront,
                  color: Colors.cyan,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(MyMarkeyPage.routeName);
                }),
            ListTile(
                title: Text('Quotes'),
                leading: Icon(
                  Icons.format_quote,
                  color: Colors.green,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(QuotesPagePage.routeName);
                }),
            ListTile(
                title: Text('Chat'),
                leading: Icon(
                  Icons.chat_rounded,
                  color: Colors.deepOrange,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(ChatPage.routeName);
                }),
            ListTile(
              title: Text('Online Content'),
              leading: Icon(
                Icons.local_fire_department_sharp,
                color: Colors.redAccent,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(OnlineContentPage.routeName);
              },
            ),
            ListTile(
              title: Text('Rating'),
              leading: Icon(
                Icons.star_rate_rounded,
                color: Colors.orange,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                  RatingPage.routeName,
                );
              },
            ),
            ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(SettingsPage.routeName);
                }),
            ListTile(
                title: Text('Help'),
                leading: Icon(
                  Icons.help_center,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () {}),
            ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.info,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () {}),
            ListTile(
                title: Text('Logout'),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                onTap: () {
                  Provider.of<MapProvider>(context, listen: false)
                      .controller!
                      .dispose();
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginPage.routeName, (r) => false);
                }),
          ],
        ),
      ),
    );
  }
}
