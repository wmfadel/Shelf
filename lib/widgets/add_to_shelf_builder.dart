import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/api_book.dart';
import 'package:shelf/pages/create_shelf_screen.dart';
import 'package:shelf/providers/auth_provider.dart';

class AddToShelfBuilder extends StatelessWidget {
  final APIBook book;
  final BuildContext scaffoldCTX;
  AddToShelfBuilder(this.book, this.scaffoldCTX);
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('shelfs')
            .where('user', isEqualTo: authProvider.uid)
            .get(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Shelfs',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(CreateShelfScreen.routeName),
                        icon: Icon(Icons.add_box_rounded),
                        label: Text('Create New Shelf'),
                      ),
                    ],
                  ),
                  Divider(),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data!.size,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection('shelfs')
                                .doc(snapshot.data!.docs[index].id)
                                .collection('books')
                                .doc(book.id)
                                .set(book.toJson());

                            ScaffoldMessenger.of(scaffoldCTX).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Book Added to Shelf succesfully')));
                            Navigator.of(context).pop();
                          },
                          leading: Icon(
                            Icons.add_box_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          title: Text((snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>)['name']
                              .replaceAll('!@#', ' ')),
                        );
                      }),
                  Text('Total shelfs ${snapshot.data!.size}'),
                ],
              ),
            ),
          );
        });
  }
}
