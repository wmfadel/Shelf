import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  late String id;
  String? text;
  late String user;
  String? replyTo;
  late Timestamp date;
  List<String>? images;
  List<String>? comments;
  List<String>? likes;

  Post(
      {required this.id,
      this.text,
      required this.user,
      this.replyTo,
      required this.date,
      this.images,
      this.comments,
      this.likes});

  Post.fromJson(Map<String, dynamic> json, String postID) {
    id = postID;
    text = json['text'];
    user = json['user'];
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
    data['reply-to'] = this.replyTo;
    data['date'] = this.date;
    data['images'] = this.images;
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    return data;
  }
}
