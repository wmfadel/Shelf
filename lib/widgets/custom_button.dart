import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  final Color? color;
  CustomButton({
    required this.iconData,
    required this.onPressed,
    this.color,
  });
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
            icon: Icon(iconData,
                color: color ?? Theme.of(context).iconTheme.color),
            onPressed: onPressed as void Function()?,
          ),
        ),
      ),
    );
  }
}
