class MarketBook {
  //String? date;
  bool? sold;
  String? thumbnail;
  String? userId;
  String? title;
  List<String>? photos;
  String? buyer;
  String? userName;
  String? iSBN;
  String? price;
  String? location;
  String? id;
  String? email;
  List<String>? authors;

  MarketBook(
      { //this.date,
      this.sold,
      this.thumbnail,
      this.userId,
      this.title,
      this.photos,
      this.buyer,
      this.userName,
      this.iSBN,
      this.price,
      this.location,
      this.id,
      this.email,
      this.authors});

  MarketBook.fromJson(Map<String, dynamic> json) {
    // date = json['date'];
    sold = json['sold'];
    thumbnail = json['thumbnail'];
    userId = json['user-id'];
    title = json['title'];
    photos = json['photos'].cast<String>();
    buyer = json['buyer'];
    userName = json['user-name'];
    iSBN = json['ISBN'];
    price = json['price'];
    location = json['location'];
    id = json['id'];
    email = json['email'];
    authors = json['authors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['date'] = this.date;
    data['sold'] = this.sold;
    data['thumbnail'] = this.thumbnail;
    data['user-id'] = this.userId;
    data['title'] = this.title;
    data['photos'] = this.photos;
    data['buyer'] = this.buyer;
    data['user-name'] = this.userName;
    data['ISBN'] = this.iSBN;
    data['price'] = this.price;
    data['location'] = this.location;
    data['id'] = this.id;
    data['email'] = this.email;
    data['authors'] = this.authors;
    return data;
  }
}
