import 'package:flutter/material.dart';
import 'package:shelf/widgets/profile_widgets/profile_personal_info.dart';
import 'package:shelf/widgets/profile_widgets/tabs_handle_widget.dart';

class ProfilePage extends StatelessWidget {
  static final String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final String uid = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          ProfilePersonalInfo(uid: uid),
          TabsHandleWidget(uid),
        ],
      ),
    );
  }
}
