import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shelf/models/api_book.dart';

class BooksAPISearchService {
  final String _searchURL = 'https://www.googleapis.com/books/v1/volumes?q=';

  Future<List<APIBook>> searchAPIBook(String name) async {
    String url = _searchURL + name;
    print('searching for book on $url');
    http.Response response = await http.get(url);
    Map<String, dynamic> res = json.decode(response.body);
    List<APIBook> books = [];
    for (var item in res['items']) {
      books.add(APIBook.fromJson(item));
    }
    print('books found ${books[0].toJson()}');
    return books;
  }
}
