import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/services/location_service.dart';

class VisibilitySwitch extends StatefulWidget {
  @override
  _VisibilitySwitchState createState() => _VisibilitySwitchState();
}

class _VisibilitySwitchState extends State<VisibilitySwitch> {
  bool isSwitch = false;
  bool? dynamicSwitch = false;

  handleSwitch(bool value, String? uid) async {
    if (value) {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.data()!['location'] == null) {
        String? newLocation = await LocationService().getUserLocation();
        if (newLocation == null) {
          return;
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .update({'location': newLocation});
        }
      }
    }
    setState(() {
      isSwitch = value;
      dynamicSwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<AuthProvider>(context, listen: false).uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.doc('users/$uid').snapshots(),
      builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return dummyPlaceHolder();
        dynamicSwitch = snapshot.data!.data()!['visibility'];
        return SwitchListTile(
          value: dynamicSwitch != true ? isSwitch : dynamicSwitch!,
          title: Text(dynamicSwitch != true
              ? isSwitch
                  ? 'Visibile'
                  : 'Invisible'
              : 'Visible'),
          subtitle: Text('change (location\\shelfs) visibility'),
          onChanged: (val) {
            handleSwitch(val, uid);
            FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .update({'visibility': val});
          },
        );
      },
    );
  }

  Widget dummyPlaceHolder() {
    return SwitchListTile(
      value: false,
      title: Text('Visibile'),
      subtitle: Text('change (location\\shelfs) visibility'),
      onChanged: (val) {},
    );
  }
}
