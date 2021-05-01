import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/quote.dart';

class QuotesListItem extends StatelessWidget {
  final Quote quote;

  QuotesListItem({required this.quote});

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
            ],
          ),
        ),
      ),
    );
  }
}
