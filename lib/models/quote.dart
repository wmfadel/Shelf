import 'package:cloud_firestore/cloud_firestore.dart';

class Quote {
  late String text;
  late String author;
  late String book;
  late Timestamp date;
  late String page;

  Quote({
    required this.text,
    required this.author,
    required this.book,
    required this.date,
    required this.page,
  });

  Quote.fromFire(Map<String, dynamic> json) {
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
