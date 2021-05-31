import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookProgress extends StatefulWidget {
  String bookId;
  String shelfID;
  double value;
  int maxValue;

  BookProgress(
      {required this.bookId,
      required this.shelfID,
      required this.value,
      required this.maxValue});
  @override
  _BookProgressState createState() => _BookProgressState();
}

class _BookProgressState extends State<BookProgress> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.value.toString(),
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Slider(
            value: widget.value,
            max: double.parse('${widget.maxValue}'),
            min: 0,
            label: '${widget.value}',
            divisions: widget.maxValue,
            onChanged: (v) {
              setState(() {
                widget.value = v;
              });
            },
            onChangeEnd: (v) {
              FirebaseFirestore.instance
                  .collection('shelfs')
                  .doc(widget.shelfID)
                  .collection('books')
                  .doc(widget.bookId)
                  .update({'progress': v});
            },
          ),
        ),
        Text(
          widget.maxValue.toString(),
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            bool completed = widget.value == double.parse('${widget.maxValue}');
            if (completed) {
              setState(() {
                widget.value = 0;
              });
            } else {
              setState(() {
                widget.value = double.parse('${widget.maxValue}');
                FirebaseFirestore.instance
                    .collection('shelfs')
                    .doc(widget.shelfID)
                    .collection('books')
                    .doc(widget.bookId)
                    .update({'progress': widget.maxValue});
              });
            }
          },
          child: Container(
            width: 90,
            height: 35,
            child: Center(
              child: Text(
                'Completed',
                style: TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              color: widget.value == double.parse('${widget.maxValue}')
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ],
    );
  }
}
