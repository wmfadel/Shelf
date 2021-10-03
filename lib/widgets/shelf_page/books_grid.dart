import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/api_book.dart';
import 'package:shelf/pages/book_page.dart';
import 'package:shelf/widgets/shelf_page/books_grid_item.dart';
import 'package:shelf/widgets/shelf_page/grid_adder.dart';

class BooksGrid extends StatefulWidget {
  final String shelfID;
  final bool isEdible;

  BooksGrid(
    this.shelfID, {
    this.isEdible = true,
  });

  @override
  _BooksGridState createState() => _BooksGridState();
}

class _BooksGridState extends State<BooksGrid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('shelfs')
          .doc(widget.shelfID)
          .collection('books')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: CircularProgressIndicator(),
          ));
        List<APIBook> books = [];
        snapshot.data?.docs.forEach((QueryDocumentSnapshot fireBook) {
          books.add(APIBook.fromFire(fireBook.data()));
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
              late Dialog errorDialog;
              if (books.length > 0 && index != books.length) {
                errorDialog = Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12.0)), //this right here
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'Confirm Delete!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Are you sure you want to remove \"${books[index].title}\" from this shelf',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                            maxLines: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Cancel')),
                              ElevatedButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('shelfs')
                                      .doc(widget.shelfID)
                                      .collection('books')
                                      .doc(books[index].id)
                                      .delete();
                                  Navigator.of(context).pop(true);
                                },
                                child: Text('remove'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.red[700]!;
                                    },
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }

              return (index == books.length)
                  ? widget.isEdible
                      ? GridAdder()
                      : Container()
                  : GestureDetector(
                      onLongPress: () {
                        if (!widget.isEdible) return;
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return errorDialog;
                            }).then((value) {
                          if (value) setState(() {});
                        });
                      },
                      onTap: () => Navigator.of(context)
                          .pushNamed(BookPage.routeName, arguments: [
                        widget.shelfID,
                        books[index].toJson(),
                        widget.isEdible
                      ]),
                      child: BooksGridItem(book: books[index]),
                    );
            },
          ),
        );
      },
    );
  }
}
