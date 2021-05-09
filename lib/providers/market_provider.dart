import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shelf/enums/book_search_enum.dart';
import 'package:shelf/models/market_book.dart';

class MarketProvider with ChangeNotifier {
  List<MarketBook> marketBooks = [];
  List<MarketBook> searchBooks = [];
  MarketBook? _activeBook;

  getMapMarket(String currentUserID) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('market')
        .where('user-id', isNotEqualTo: currentUserID)
        .where('sold', isEqualTo: false)
        .get();

    marketBooks.clear();
    snapshot.docs.forEach((QueryDocumentSnapshot book) {
      marketBooks.add(MarketBook.fromJson(book.data()!));
    });
    notifyListeners();
  }

  removeSearchResults() {
    searchBooks.clear();
    _activeBook = null;
    notifyListeners();
  }

  searchForBook(String searchTerm, BookSearchEnum bookSearchEnum) {
    searchBooks.clear();
    switch (bookSearchEnum) {
      case BookSearchEnum.ISBN:
        marketBooks.forEach((MarketBook book) {
          if (book.iSBN!.toLowerCase().contains(searchTerm)) {
            searchBooks.add(book);
          }
        });
        break;
      case BookSearchEnum.author:
        marketBooks.forEach((MarketBook book) {
          book.authors!.forEach((String author) {
            if (author.toLowerCase().contains(searchTerm)) {
              searchBooks.add(book);
            }
          });
        });
        break;
      case BookSearchEnum.year:
        marketBooks.forEach((MarketBook book) {
          if (book.publishDate!.toLowerCase().contains(searchTerm)) {
            searchBooks.add(book);
          }
        });
        break;
      case BookSearchEnum.title:
      default:
        marketBooks.forEach((MarketBook book) {
          if (book.title!.toLowerCase().contains(searchTerm)) {
            searchBooks.add(book);
          }
        });
    }

    if (searchBooks.isNotEmpty) {
      _activeBook = searchBooks.first;
      notifyListeners();
    }
  }

  setActiveBook(MarketBook? marketBook) {
    _activeBook = marketBook;
    notifyListeners();
  }

  MarketBook? getActiveBook() {
    return _activeBook;
  }
}
