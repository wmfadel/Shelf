import 'package:flutter/material.dart';
import 'package:shelf/pages/add_book_page.dart';

class GridAdder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        clipBehavior: Clip.hardEdge,
        shadowColor: Theme.of(context).accentColor.withOpacity(0.5),
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          splashColor: Theme.of(context).accentColor,
          onTap: () => Navigator.of(context).pushNamed(AddBookPage.routeName),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.add),
                Text(
                  'Add a Book',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
