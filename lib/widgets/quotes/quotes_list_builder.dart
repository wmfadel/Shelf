import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/quote.dart';
import 'package:shelf/widgets/quotes/quotes_list.dart';

class QuotesListBuilder extends StatelessWidget {
  final String userID;
  const QuotesListBuilder({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('quotes')
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError || !snapshot.hasData)
          return Center(
              child: TextButton(
            child: Text('No Quotes added for now, Add One now!!'),
            onPressed: () {},
          ));

        return QuotesList(quotes: quotesFromList(snapshot.data?.docs ?? []));
      },
    );
  }

  List<Quote> quotesFromList(List<QueryDocumentSnapshot> data) {
    List<Quote> quotes = [];
    data.forEach((element) {
      quotes.add(Quote.fromFire(element.data()!));
    });
    return quotes;
  }
}
