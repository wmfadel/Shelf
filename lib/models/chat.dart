import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shelf/models/message.dart';

class Chat {
  late String id;
  late Timestamp date;
  late List<String> users;
  late Stream<List<Message>> messeges;

  Chat({
    required this.id,
    required this.date,
    required this.users,
  });

  Chat.fromJson(dynamic rawJson, String id) {
    Map<String, dynamic> json = rawJson as Map<String, dynamic>;
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
