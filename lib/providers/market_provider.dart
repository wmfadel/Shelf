import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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

  searchForBookByTitle(String searchTerm) {
    searchBooks.clear();
    marketBooks.forEach((MarketBook book) {
      if (book.title!.toLowerCase().contains(searchTerm)) {
        print(
            'search book title ${book.title}, contains $searchTerm? ${book.title!.contains(searchTerm)}');
        searchBooks.add(book);
      }
    });

    print('search books is search ${searchBooks.length}');
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
