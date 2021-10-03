import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RateWidget extends StatelessWidget {
  final bool isUp;
  final String userID;
  RateWidget({
    required this.userID,
    required this.isUp,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        return RateBuild(
          snapshot.data?.get(isUp ? 'upVote' : 'downVote'),
          isUp,
          userID,
        );
      },
    );
  }
}

// ignore: must_be_immutable
class RateBuild extends StatefulWidget {
  int rate;
  final bool isUp;
  final String userID;

  RateBuild(this.rate, this.isUp, this.userID);
  @override
  _RateBuildState createState() => _RateBuildState();
}

class _RateBuildState extends State<RateBuild> {
  @override
  Widget build(BuildContext context) {
    var children = [
      Text(
        widget.rate.toString(),
        style: TextStyle(
            color: widget.isUp ? Colors.blueAccent : Colors.redAccent,
            fontSize: 25),
      ),
      SizedBox(height: 15),
      FloatingActionButton(
        heroTag: widget.isUp ? 'up' : 'down',
        onPressed: () async {
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.userID)
              .update({widget.isUp ? 'upVote' : 'downVote': (++widget.rate)});
          setState(() {});
        },
        backgroundColor: widget.isUp ? Colors.blueAccent : Colors.redAccent,
        child: Icon(widget.isUp ? Icons.thumb_up : Icons.thumb_down),
      ),
    ];
    return Column(children: [
      if (widget.isUp) ...children,
      if (!widget.isUp) ...children.reversed
    ]);
  }
}
