import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  GeoPoint? location;
  String? marketBook;
  String? photo;
  String? text;
  late Timestamp time;
  late String user;

  Message(
      {this.location,
      this.marketBook,
      this.photo,
      this.text,
      required this.time,
      required this.user});

  Message.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    marketBook = json['market_book'];
    photo = json['photos'];
    text = json['text'];
    time = json['time'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['market_book'] = this.marketBook;
    data['photos'] = this.photo;
    data['text'] = this.text;
    data['time'] = this.time;
    data['user'] = this.user;
    return data;
  }
}
