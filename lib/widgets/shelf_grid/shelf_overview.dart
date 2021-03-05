import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/api_book.dart';
import 'package:shelf/widgets/shelf_grid/border_container.dart';
import 'package:shelf/widgets/shelf_grid/multi_book.dart';
import 'package:shelf/widgets/shimmer_items/shmr_shelf_overview.dart';

class ShelfOverview extends StatelessWidget {
  final String shelfID;

  const ShelfOverview({
    Key? key,
    required this.shelfID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('shelfs')
            .doc(shelfID)
            .collection('books')
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return ShmrShelfOverview();
          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
          List<APIBook> books = [];

          docs.forEach((element) {
            books.add(APIBook.fromFire(element.data()!));
          });

          return books.length > 3
              ? MultiBook(books: books)
              : BorderContainer(books: books);
        });
  }
}
