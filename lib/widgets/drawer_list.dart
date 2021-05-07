import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/chat_page.dart';
import 'package:shelf/pages/contact_me_page.dart';
import 'package:shelf/pages/create_post_page.dart';
import 'package:shelf/pages/help_page.dart';
import 'package:shelf/pages/login_page.dart';
import 'package:shelf/pages/market_page.dart';
import 'package:shelf/pages/my_market_page.dart';
import 'package:shelf/pages/online_content_page.dart';
import 'package:shelf/pages/quotes_page.dart';
import 'package:shelf/pages/rating_page.dart';
import 'package:shelf/pages/settings_page.dart';
import 'package:shelf/pages/social_page.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/map_provider.dart';
import 'package:shelf/widgets/drawer_heading.dart';
import 'package:shelf/widgets/drawer_item.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeading(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                'Interact',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerItem(
              text: 'Social',
              color: Colors.deepPurple,
              icon: Icons.deck,
              destination: SocialPage.routeName,
            ),
            DrawerItem(
              text: 'Create',
              color: Colors.deepPurple,
              icon: Icons.create_new_folder,
              destination: CreatePostPage.routeName,
            ),
            DrawerItem(
              text: 'Chat',
              color: Colors.deepPurple,
              icon: Icons.chat_rounded,
              destination: ChatPage.routeName,
            ),
            DrawerItem(
              text: 'Online Content',
              color: Colors.deepPurple,
              icon: Icons.local_fire_department_sharp,
              destination: OnlineContentPage.routeName,
            ),
            Divider(color: Colors.deepPurple),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                'Trade',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerItem(
              text: 'Market',
              color: Colors.green,
              icon: Icons.store_mall_directory,
              destination: MarketPage.routeName,
            ),
            DrawerItem(
              text: 'My Market',
              color: Colors.green,
              icon: Icons.storefront,
              destination: MyMarkeyPage.routeName,
            ),
            DrawerItem(
              text: 'Quotes',
              color: Colors.green,
              icon: Icons.format_quote,
              destination: QuotesPage.routeName,
            ),
            Divider(color: Colors.green),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                'Improve',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerItem(
              text: 'Rating',
              color: Colors.deepOrange,
              icon: Icons.star_rate_rounded,
              destination: RatingPage.routeName,
            ),
            Divider(color: Theme.of(context).iconTheme.color!),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                'Control',
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color!,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerItem(
              text: 'Settings',
              color: Theme.of(context).iconTheme.color!,
              icon: Icons.settings,
              destination: SettingsPage.routeName,
            ),
            DrawerItem(
              text: 'Help',
              color: Theme.of(context).iconTheme.color!,
              icon: Icons.help_center,
              destination: HelpPage.routeName,
            ),
            DrawerItem(
              text: 'About',
              color: Theme.of(context).iconTheme.color!,
              icon: Icons.info,
              destination: SettingsPage.routeName,
            ),
            DrawerItem(
              text: 'Contact Me',
              color: Theme.of(context).iconTheme.color!,
              icon: Icons.alternate_email,
              destination: ContactMePage.routeName,
            ),
            Divider(
              color: Colors.red,
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                'Leave',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerItem(
              text: 'Logout',
              color: Colors.red,
              icon: Icons.exit_to_app,
              destination: '',
              action: () {
                Provider.of<MapProvider>(context, listen: false)
                    .controller!
                    .dispose();
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(LoginPage.routeName, (r) => false);
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
