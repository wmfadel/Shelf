import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  late String id;
  late Timestamp date;
  late List<String> users;

  Chat({
    required this.id,
    required this.date,
    required this.users,
  });

  Chat.fromJson(Map<String, dynamic> json, String id) {
    this.id = id;
    date = json['date'];
    users = json['users'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['users'] = this.users;
    return data;
  }
}
