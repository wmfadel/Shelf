import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  late String id;
  String? text;
  late String user;
  late String name;
  late String email;
  late String photo;
  String? replyTo;
  late Timestamp date;
  List<String>? images;
  List<String>? comments;
  List<String>? likes;

  Post(
      {required this.id,
      this.text,
      required this.user,
      required this.name,
      required this.email,
      required this.photo,
      this.replyTo,
      required this.date,
      this.images,
      this.comments,
      this.likes});

  Post.fromJson(dynamic rawJson, String postID) {
    final json = rawJson as Map<String, dynamic>;
    id = postID;
    text = json['text'];
    user = json['user'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    replyTo = json['reply-to'];
    date = json['date'];
    images = json['images'].cast<String>();
    comments = json['comments'].cast<String>();
    likes = json['likes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['user'] = this.user;
    data['name'] = this.name;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['reply-to'] = this.replyTo;
    data['date'] = this.date;
    data['images'] = this.images;
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    return data;
  }
}
