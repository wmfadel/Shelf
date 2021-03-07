import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShelfPageSwitch extends StatefulWidget {
  bool isPublic;
  String shelfId;
  ShelfPageSwitch({
    required this.isPublic,
    required this.shelfId,
  });

  @override
  _ShelfPageSwitchState createState() => _ShelfPageSwitchState();
}

class _ShelfPageSwitchState extends State<ShelfPageSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
          border: Border.all(
              color: widget.isPublic ? Colors.blue : Colors.red, width: 2),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Icon(
            widget.isPublic ? Icons.lock_open_outlined : Icons.lock_outlined,
            color: widget.isPublic ? Colors.blue : Colors.red,
          ),
          Switch(
              value: widget.isPublic,
              inactiveTrackColor: Colors.redAccent[100],
              inactiveThumbColor: Colors.red,
              onChanged: (bool newValue) {
                setState(() {
                  widget.isPublic = newValue;
                });
                FirebaseFirestore.instance
                    .collection('shelfs')
                    .doc(widget.shelfId)
                    .update({'isPublic': widget.isPublic});
              }),
        ],
      ),
    );
  }
}
