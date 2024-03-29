import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/api_book.dart';

class BooksGridItem extends StatelessWidget {
  const BooksGridItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  final APIBook book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        clipBehavior: Clip.hardEdge,
        shadowColor: Theme.of(context).colorScheme.secondary,
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                book.thumbnail!,
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Text(
                book.title!,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
