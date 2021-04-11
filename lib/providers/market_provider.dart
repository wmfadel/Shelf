import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shelf/models/market_book.dart';

class MarketProvider with ChangeNotifier {
  List<MarketBook> marketBooks = [];
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

  setActiveBook(MarketBook marketBook) {
    _activeBook = marketBook;
    notifyListeners();
  }

  MarketBook? getActiveBook() {
    return _activeBook;
  }
}
