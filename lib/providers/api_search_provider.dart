import 'package:flutter/foundation.dart';
import 'package:shelf/models/api_book.dart';
import 'package:shelf/services/book_api_search_service.dart';

class APISearchPRovider with ChangeNotifier {
  bool _isLoading = false;
  List<APIBook> _books = [];
  BooksAPISearchService _searchService = BooksAPISearchService();
  String _selectedBookID;
  List<APIBook> get books => _books;
  bool get isLoading => _isLoading;
  set selectedBookID(String id) {
    _selectedBookID = id;
  }

  Future<bool> searchForABook(String name) async {
    _isLoading = true;
    notifyListeners();
    _books = await _searchService.searchAPIBook(name);
    _isLoading = false;
    notifyListeners();
    if (_books == null || _books.length == 0) return false;
    return true;
  }

  APIBook getSelectedBook() {
    return _books.firstWhere((APIBook b) => b.id == _selectedBookID,
        orElse: () => null);
  }
}
