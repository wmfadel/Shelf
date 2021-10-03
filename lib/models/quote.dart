import 'package:cloud_firestore/cloud_firestore.dart';

class Quote {
  String? id;
  late String text;
  late String author;
  late String book;
  late Timestamp date;
  late String page;

  Quote({
    this.id,
    required this.text,
    required this.author,
    required this.book,
    required this.date,
    required this.page,
  });

  Quote.fromFire(dynamic rawJson, String docID) {
    Map<String, dynamic> json = rawJson as Map<String, dynamic>;
    id = docID;
    text = json['text'] ?? '';
    author = json['author'] ?? 'Unknown Author';
    book = json['book'] ?? 'Unknown Book Title';
    date = json['date'];
    page = json['page'] ?? '1';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['author'] = this.author;
    data['book'] = this.book;
    data['date'] = this.date;
    data['page'] = this.page;
    return data;
  }
}
