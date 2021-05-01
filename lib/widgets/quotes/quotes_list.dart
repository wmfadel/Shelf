import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/quote.dart';

class QuotesList extends StatelessWidget {
  final List<Quote> quotes;

  QuotesList({required this.quotes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quotes.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(quotes[index].author),
        );
      },
    );
  }
}
