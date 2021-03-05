import 'package:shelf/models/api_book.dart';

class Shelf {
  String id;
  String name;
  String description;
  String user;
  String time;
  List<APIBook>? books;

  Shelf({
    required this.id,
    required this.name,
    required this.description,
    required this.user,
    required this.time,
    this.books,
  });
}
