import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('users').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();

        int totalUp = 0;
        int totalDown = 0;
        snapshot.data?.docs.forEach((QueryDocumentSnapshot element) {
          totalUp += int.parse(element.get('upVote').toString());
          totalDown += int.parse(element.get('downVote').toString());
        });
        return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_drop_up, color: Colors.blueAccent, size: 50),
              Text(
                totalUp.toString(),
                style: TextStyle(color: Colors.blueAccent, fontSize: 20),
              ),
              SizedBox(width: 15),
              Icon(Icons.arrow_drop_down, color: Colors.redAccent, size: 50),
              Text(
                totalDown.toString(),
                style: TextStyle(color: Colors.redAccent, fontSize: 20),
              )
            ]);
      },
    );
  }
}
