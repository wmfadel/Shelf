import 'package:flutter/material.dart';
import 'package:shelf/widgets/visibility_switch.dart';

class SettingsPage extends StatelessWidget {
  static final String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            VisibilitySwitch(),
          ],
        ),
      ),
    );
  }
}
