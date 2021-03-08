import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/api_book.dart';
import 'package:shelf/widgets/shelf_page/books_grid_item.dart';
import 'package:shelf/widgets/shelf_page/grid_adder.dart';

class BooksGrid extends StatelessWidget {
  final String shelfID;
  final bool isEdible;

  BooksGrid(
    this.shelfID, {
    this.isEdible = true,
  });
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('shelfs')
          .doc(shelfID)
          .collection('books')
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: CircularProgressIndicator(),
          ));
        List<APIBook> books = [];
        snapshot.data?.docs.forEach((QueryDocumentSnapshot fireBook) {
          books.add(APIBook.fromFire(fireBook.data()!));
        });

        return Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: GridView.builder(
            itemCount: (books.length + 1),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.7,
            ),
            itemBuilder: (BuildContext context, int index) {
              return (index == books.length)
                  ? isEdible
                      ? GridAdder()
                      : Container()
                  : BooksGridItem(book: books[index]);
            },
          ),
        );
      },
    );
  }
}
