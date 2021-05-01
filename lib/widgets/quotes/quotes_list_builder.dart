import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/quote.dart';
import 'package:shelf/widgets/quotes/quotes_list_item.dart';

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
        List<Quote> quotes = quotesFromList(snapshot.data?.docs ?? []);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  // TODO: Navigate to add quote page
                },
                child: Material(
                  color: Theme.of(context).primaryColor,
                  elevation: 8,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          'Add new Quote',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (BuildContext context, int index) {
                  return QuotesListItem(quote: quotes[index]);
                },
              ),
            ),
          ],
        );
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
