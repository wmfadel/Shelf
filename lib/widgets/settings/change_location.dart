import 'package:flutter/material.dart';
import 'package:shelf/widgets/settings/change_location_map.dart';

class ChangeLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Change Location'),
      leading: Icon(
        Icons.location_on_outlined,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) {
              return ChangeLocationMap();
            });
      },
    );
  }
}
