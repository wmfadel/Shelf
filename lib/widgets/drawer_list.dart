import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/login_page.dart';
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
