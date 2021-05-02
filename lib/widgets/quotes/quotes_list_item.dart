import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shelf/models/quote.dart';
import 'package:shelf/providers/auth_provider.dart';

class QuotesListItem extends StatelessWidget {
  final Quote quote;
  final String userID;

  QuotesListItem({
    required this.quote,
    required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 5, 15),
      child: Material(
        color: Colors.white,
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SelectableText(
                '"${quote.text}"',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.auto_stories),
                    SizedBox(width: 5),
                    Expanded(child: SelectableText(quote.book)),
                    Icon(Icons.auto_stories),
                    SizedBox(width: 5),
                    Text('Page ${quote.page}'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.history_edu),
                    SizedBox(width: 5),
                    Expanded(child: SelectableText(quote.author)),
                    Icon(Icons.schedule),
                    SizedBox(width: 5),
                    Text(
                        '${quote.date.toDate().year}-${quote.date.toDate().month}-${quote.date.toDate().day}'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (userID ==
                      Provider.of<AuthProvider>(context, listen: false).uid)
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print(
                                              'deleting quote with id: ${quote.id}');
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userID)
                                              .collection('quotes')
                                              .doc(quote.id)
                                              .delete();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Delete'),
                                      )
                                    ],
                                    title: Text('Confirm'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Are you sure you want to delete this quote',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ));
                              });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(
                                '"${quote.text}", ${quote.author} - ${quote.book} page ${quote.page}')
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Quote copied to Clipboard')));
                        });
                      },
                      icon: Icon(
                        Icons.copy,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () {
                        Share.share(
                            '"${quote.text}", ${quote.author} - ${quote.book} page ${quote.page}, Shared from Shelf');
                      },
                      icon: Icon(Icons.share)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
