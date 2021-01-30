import 'package:flutter/material.dart';
import 'package:shelf/models/api_book.dart';

import 'package:shelf/services/book_api_search_service.dart';
import 'package:shelf/widgets/api_book_list_item.dart';

class AddBookPage extends StatefulWidget {
  static final String routeName = '/addBook';

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<APIBook> books = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Add Books on your Shelf',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TextField(
                    controller: _textEditingController,
                    maxLines: 2,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      labelText: 'Search for books on your shelf',
                      hintText: 'Normal People ...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          print('text: ${_textEditingController.text}');
                          books = await BooksAPISearchService().searchAPIBook(
                              _textEditingController.text.replaceAll(' ', '+'));
                          if (books != null && books.length > 0)
                            setState(() {
                              isLoading = false;
                            });
                        },
                ),
              ],
            ),
          ),
          if (books == null || books.length == 0) SizedBox(height: 100),
          if (books == null || books.length == 0)
            Image.asset('assets/pics/bibliophile.png'),
          if (books.length > 0)
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                primary: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    APIBookListItem(books[index]),
              ),
            ),
        ],
      ),
    );
  }
}
