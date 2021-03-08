import 'package:flutter/material.dart';
import 'package:shelf/widgets/change_location.dart';
import 'package:shelf/widgets/visibility_switch.dart';

class SettingsPage extends StatelessWidget {
  static final String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            VisibilitySwitch(),
            ChangeLocation(),
          ],
        ),
      ),
    );
  }
}
