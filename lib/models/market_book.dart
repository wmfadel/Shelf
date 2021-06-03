import 'package:cloud_firestore/cloud_firestore.dart';

class MarketBook {
  Timestamp? date;
  bool? sold;
  String? thumbnail;
  String? userId;
  String? title;
  List<String>? photos;
  String? publishDate;
  String? buyer;
  String? userName;
  String? userPhoto;
  String? iSBN;
  double? price;
  String? location;
  String? id;
  String? email;
  List<String>? authors;
  String? marketID;

  MarketBook(
      {this.date,
      this.sold,
      this.thumbnail,
      this.userId,
      this.title,
      this.photos,
      this.publishDate,
      this.buyer,
      this.userName,
      this.userPhoto,
      this.iSBN,
      this.price,
      this.location,
      this.id,
      this.email,
      this.authors});

  MarketBook.fromJson(Map<String, dynamic> json, {String? marketID}) {
    date = json['date'];
    sold = json['sold'];
    thumbnail = json['thumbnail'];
    userId = json['user-id'];
    title = json['title'];
    photos = json['photos'].cast<String>();
    publishDate = json['publish-date'] ?? '';
    buyer = json['buyer'];
    userName = json['user-name'];
    userPhoto = json['user-photo'];
    iSBN = json['ISBN'];
    if (json['price'].toString().isEmpty) {
      price = 0;
    } else {
      price = double.parse(json['price']);
    }

    location = json['location'];
    id = json['id'];
    email = json['email'];
    authors = json['authors'].cast<String>();
    this.marketID = marketID;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['sold'] = this.sold;
    data['thumbnail'] = this.thumbnail;
    data['user-id'] = this.userId;
    data['title'] = this.title;
    data['photos'] = this.photos;
    data['publish-date'] = this.publishDate;
    data['buyer'] = this.buyer;
    data['user-name'] = this.userName;
    data['user-photo'] = this.userPhoto;
    data['ISBN'] = this.iSBN;
    data['price'] = this.price.toString();
    data['location'] = this.location;
    data['id'] = this.id;
    data['email'] = this.email;
    data['authors'] = this.authors;
    return data;
  }
}
