import 'package:flutter/material.dart';

class InfoChipText extends StatelessWidget {
  final String type;
  final String value;
  final Color color;

  InfoChipText(this.type, this.value, {this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            type,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 8),
          Container(
            child: Text('$value',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(25)),
    );
  }
}
