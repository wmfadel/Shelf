import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  late Timestamp date;
  late List<String> users;

  Chat({
    required this.date,
    required this.users,
  });

  Chat.fromJson(Map<String, dynamic> json) {
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
