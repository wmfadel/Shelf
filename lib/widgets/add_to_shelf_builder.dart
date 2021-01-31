import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/api_book.dart';
import 'package:shelf/providers/auth_provider.dart';

class AddToShelfBuilder extends StatelessWidget {
  final APIBook book;
  AddToShelfBuilder(this.book);
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users/${authProvider.uid}/shelfs')
            .get(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Shelfs',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Icon(Icons.add_box_rounded, color: Colors.greenAccent),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                labelText: 'Add New Shelf',
                                hintText: 'My New great shelf ...'),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection(
                              'users/${authProvider.uid}/shelfs/${snapshot.data.docs.first.id}/books')
                          .doc(book.id)
                          .set(book.toJson());
                    },
                    leading: Icon(
                      Icons.add_box_rounded,
                      color: Colors.blue,
                    ),
                    title: Text(snapshot.data.docs.first.id),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
