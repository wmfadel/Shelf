import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final String destination;
  final Function? action;

  DrawerItem({
    required this.text,
    required this.color,
    required this.icon,
    required this.destination,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (action == null) {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(destination);
        } else {
          action!();
        }
      },
      child: Container(
        height: 50,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color.withOpacity(0.2),
        ),
      ),
    );
  }
}
