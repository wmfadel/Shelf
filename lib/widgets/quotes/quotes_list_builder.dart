import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/quote.dart';
import 'package:shelf/pages/add_quote_page.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/quotes/quotes_list_item.dart';

class QuotesListBuilder extends StatelessWidget {
  final String userID;
  const QuotesListBuilder({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('quotes')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError || !snapshot.hasData)
          return Center(
              child: TextButton(
            child: Text('No Quotes added for now, Add One now!!'),
            onPressed: () {},
          ));
        bool? isEmpty = snapshot.data?.docs.isEmpty ?? false;
        if (isEmpty) {
          if (userID == Provider.of<AuthProvider>(context, listen: false).uid) {
            return Center(
                child: TextButton(
              child: Text('No Quotes added for now, Add One now!!'),
              onPressed: () {},
            ));
          } else {
            return Center(
                child: Text('No Quotes added for now, Add One now!!'));
          }
        }

        List<Quote> quotes = quotesFromList(snapshot.data?.docs ?? []);
        return Column(
          children: [
            if (userID == Provider.of<AuthProvider>(context, listen: false).uid)
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddQuotePage.routeName);
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
                  return QuotesListItem(quote: quotes[index], userID: userID);
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
      Quote temp = Quote.fromFire(element.data()!, element.id);
      quotes.add(temp);
      print('quote id on creation ${element.id}, got ${temp.id}');
    });
    return quotes;
  }
}
