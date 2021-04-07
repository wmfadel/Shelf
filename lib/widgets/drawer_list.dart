import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/login_page.dart';
import 'package:shelf/pages/market_page.dart';
import 'package:shelf/pages/my_market_page.dart';
import 'package:shelf/pages/online_content_page.dart';
import 'package:shelf/pages/rating_page.dart';
import 'package:shelf/pages/settings_page.dart';
import 'package:shelf/providers/auth_provider.dart';
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
                title: Text('transactions'),
                leading: Icon(
                  Icons.call_to_action_rounded,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(MyMarkeyPage.routeName);
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
