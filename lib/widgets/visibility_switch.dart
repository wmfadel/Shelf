import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class VisibilitySwitch extends StatefulWidget {
  @override
  _VisibilitySwitchState createState() => _VisibilitySwitchState();
}

class _VisibilitySwitchState extends State<VisibilitySwitch> {
  bool isSwitch = false;
  bool dynamicSwitch;

  handleSwitch(bool value) {
    setState(() {
      isSwitch = value;
      dynamicSwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<AuthProvider>(context, listen: false).uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.doc('users/$uid').snapshots(),
      builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return dummyPlaceHolder();
        dynamicSwitch = snapshot.data.data()['visibility'];
        return SwitchListTile(
          value: dynamicSwitch != true ? isSwitch : dynamicSwitch,
          title: Text(isSwitch ? 'Visibile' : 'Invisible'),
          subtitle: Text('change (location\\shelfs) visibility'),
          onChanged: (val) {
            handleSwitch(val);
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
