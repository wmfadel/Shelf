import 'package:flutter/material.dart';
import 'package:shelf/services/book_api_search_service.dart';

class AddBookPage extends StatelessWidget {
  static final String routeName = '/addBook';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          BooksAPISearchService().searchAPIBook('ikigai');
        },
      ),
    );
  }
}
