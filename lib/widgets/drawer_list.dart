import 'package:flutter/material.dart';
import 'package:shelf/pages/settings_page.dart';
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
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(SettingsPage.routeName);
                }),
          ],
        ),
      ),
    );
  }
}
