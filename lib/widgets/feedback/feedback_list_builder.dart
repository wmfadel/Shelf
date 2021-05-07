import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class FeedbackListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('feedback')
          .where('user',
              isEqualTo: Provider.of<AuthProvider>(context, listen: false).uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text('error fetching your previous feedbacks'));
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
          return Center(child: Text('You have no previous feedback'));

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DateTime date =
                (snapshot.data?.docs[index].get('time') as Timestamp).toDate();
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Material(
                color: Colors.white,
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${date.year}-${date.month}-${date.day}, ${date.hour}:${date.minute}',
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          snapshot.data?.docs[index].get('text'),
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16),
                        ),
                        Wrap(
                          spacing: 10,
                          alignment: WrapAlignment.center,
                          direction: Axis.horizontal,
                          children: (snapshot.data?.docs[index].get('topics')
                                  as List<dynamic>)
                              .map(
                                (e) => Chip(
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                  label: Text(
                                    e.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
