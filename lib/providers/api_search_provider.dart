import 'package:flutter/foundation.dart';
import 'package:shelf/models/api_book.dart';
import 'package:shelf/services/book_api_search_service.dart';

class APISearchPRovider with ChangeNotifier {
  bool isLoading = false;
  List<APIBook> books = [];
  BooksAPISearchService _searchService = BooksAPISearchService();

  Future<bool> searchForABook(String name) async {
    isLoading = true;
    notifyListeners();
    books = await _searchService.searchAPIBook(name);
    isLoading = false;
    notifyListeners();
    if (books == null || books.length == 0) return false;
    return true;
  }
}
