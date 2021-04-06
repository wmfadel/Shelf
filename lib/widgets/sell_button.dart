import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/api_book.dart';
import 'package:shelf/providers/auth_provider.dart';

class SellButton extends StatefulWidget {
  final String bookID;
  final String shelfID;

  SellButton({
    required this.bookID,
    required this.shelfID,
  });

  @override
  _SellButtonState createState() => _SellButtonState();
}

class _SellButtonState extends State<SellButton> {
  late final AuthProvider authProvider;
  bool onSale = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('market').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();

        if (!snapshot.hasError || (snapshot.data?.docs.length ?? 0) > 0) {
          snapshot.data?.docs.forEach((QueryDocumentSnapshot item) {
            if (item.get('id') == widget.bookID) {
              onSale = true;
            }
          });
        }
        return IconButton(
          color: onSale ? Colors.redAccent : Colors.green,
          onPressed: () async {
            if (onSale) {
              // TODO remove from market

            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController priceController =
                        TextEditingController();
                    return AlertDialog(
                      title: Text('Set your expected price'),
                      content: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Price',
                                labelText: 'Price... EGP',
                              ),
                            ),
                          ),
                          Text('EGP')
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancel')),
                        ElevatedButton(
                            onPressed: () async {
                              // add book to market
                              DocumentSnapshot fireDoc = await FirebaseFirestore
                                  .instance
                                  .collection('shelfs')
                                  .doc(widget.shelfID)
                                  .collection('books')
                                  .doc(widget.bookID)
                                  .get();
                              APIBook apiBook =
                                  APIBook.fromFire(fireDoc.data()!);
                              FirebaseFirestore.instance
                                  .collection('market')
                                  .add({
                                'id': apiBook.id,
                                'ISBN': apiBook.industryIdentifiers?.first
                                        .identifier ??
                                    'NOT-FOUND',
                                'thumbnail': apiBook.thumbnail,
                                'authors': apiBook.authors,
                                'price': priceController.value.text
                                    .trim()
                                    .toString(),
                                'date': DateTime.now(),
                                'user-name': authProvider.name,
                                'user-id': authProvider.uid,
                                'email': authProvider.email,
                                'location': authProvider.location,
                                'photos': [],
                              });
                              Navigator.of(context).pop(true);
                            },
                            child: Text('Add'))
                      ],
                    );
                  }).then((value) {
                if (value)
                  setState(() {
                    onSale = true;
                  });
              });
            }
          },
          icon: Icon(Icons.outbox),
        );
      },
    );
  }
}
