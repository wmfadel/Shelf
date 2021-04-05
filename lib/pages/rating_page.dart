import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/rate_widget.dart';

class RatingPage extends StatefulWidget {
  static final String routeName = 'rating_page';

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  late String userID;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userID = Provider.of<AuthProvider>(context, listen: false).uid!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity, height: 64),
          Text(
            'My Rating',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          SizedBox(height: 50),
          RateWidget(userID: userID, field: 'upVote'),
          SizedBox(height: 15),
          FloatingActionButton(
            heroTag: 'up',
            onPressed: () {
              vote('upVote');
            },
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.thumb_up),
          ),
          SizedBox(height: 30),
          FloatingActionButton(
            heroTag: 'down',
            onPressed: () {
              vote('downVote');
            },
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.thumb_down),
          ),
          SizedBox(height: 15),
          RateWidget(
            userID: userID,
            field: 'downVote',
            color: Colors.redAccent,
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  vote(String field) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .update({field: (doc.get(field) + 1)}).then((_) {
      setState(() {});
    });
  }
}
