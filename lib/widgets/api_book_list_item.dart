import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/api_book.dart';
import 'package:shelf/pages/book_page.dart';
import 'package:shelf/providers/api_search_provider.dart';

class APIBookListItem extends StatelessWidget {
  final APIBook? book;
  APIBookListItem({@required this.book});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          Provider.of<APISearchPRovider>(context, listen: false)
              .selectedBookID = book!.id;
          Navigator.of(context).pushNamed(BookPage.routeName);
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Material(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  padding: EdgeInsets.only(
                    left: 90,
                    top: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book!.title!,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        book!.subtitle ?? 'No subtitle available.',
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.pages_rounded, color: Colors.blue),
                          Text('${book!.pageCount ?? 'unknown'}'),
                          SizedBox(width: 10),
                          Icon(Icons.language_outlined, color: Colors.blue),
                          Text(book!.language!),
                          IconButton(
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.blue,
                              ),
                              onPressed: () {})
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            if (book!.thumbnail != null)
              Positioned(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: book!.id!,
                    child: Image.network(
                      book!.thumbnail!,
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
