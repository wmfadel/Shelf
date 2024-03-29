import 'package:cloud_firestore/cloud_firestore.dart';

class Shelf {
  String id;
  String name;
  String description;
  String user;
  Timestamp time;
  bool isPublic;

  Shelf({
    required this.id,
    required this.name,
    required this.description,
    required this.user,
    required this.time,
    this.isPublic = true,
  });
}
