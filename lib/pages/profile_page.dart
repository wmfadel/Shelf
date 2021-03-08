import 'package:flutter/material.dart';
import 'package:shelf/widgets/profile_personal_info.dart';
import 'package:shelf/widgets/shelf_grid/profile_shelf_grid_builder.dart';

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
          Padding(
            padding: const EdgeInsets.all(10),
            child: Divider(),
          ),
          ProfileShelfGridBuilder(uid: uid),
        ],
      ),
    );
  }
}
