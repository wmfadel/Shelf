import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final BuildContext scaffoldContext;
  DrawerButton({@required this.scaffoldContext});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: Container(
        width: 45,
        height: 45,
        child: Center(
          child: IconButton(
            icon: Icon(Icons.menu, color: Colors.blue),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
    );
  }
}
