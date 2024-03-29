import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/shelf_page/Shelf_page_switch.dart';
import 'package:shelf/widgets/shelf_page/books_grid.dart';
import 'package:shelf/widgets/shelf_page/shelf_page_user.dart';

class ShelfPage extends StatelessWidget {
  static final String routeName = '/shelf-page';
  @override
  Widget build(BuildContext context) {
    String? shelfID = ModalRoute.of(context)?.settings.arguments as String?;
    String currentUserID =
        Provider.of<AuthProvider>(context, listen: false).uid!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('shelfs')
              .doc(shelfID)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_back,
                                color: Theme.of(context).iconTheme.color),
                            onPressed: () => Navigator.of(context).pop()),
                        // allow changing shelf visibility if creted by current user
                        if (currentUserID == snapshot.data?.get('user'))
                          ShelfPageSwitch(
                              isPublic: snapshot.data?.get('isPublic'),
                              shelfId: shelfID!)
                      ],
                    ),
                  ),
                  Text(
                    snapshot.data?.get('name'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snapshot.data?.get('description'),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 4),
                  ShelfPageUser(snapshot.data?.get('user')),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                    child: Divider(),
                  ),
                  BooksGrid(
                    shelfID!,
                    isEdible: snapshot.data?.get('user') == currentUserID,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
