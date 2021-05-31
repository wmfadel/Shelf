class APIBook {
  String? id;
  String? etag;
  double? progress;
  String? title;
  String? subtitle;
  List<String>? authors;
  String? publishedDate;
  String? description;
  List<IndustryIdentifiers>? industryIdentifiers;
  int? pageCount;
  List<String>? categories;
  String? maturityRating;
  String? smallThumbnail;
  String? thumbnail;
  String? language;
  String? previewLink;
  String? infoLink;
  String? canonicalVolumeLink;
  String? webReaderLink;

  APIBook(
      {this.id,
      this.etag,
      this.title,
      this.subtitle,
      this.progress,
      this.authors,
      this.publishedDate,
      this.description,
      this.industryIdentifiers,
      this.pageCount,
      this.categories,
      this.maturityRating,
      this.smallThumbnail,
      this.thumbnail,
      this.language,
      this.previewLink,
      this.infoLink,
      this.canonicalVolumeLink,
      this.webReaderLink});

  APIBook.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    etag = json['etag'] ?? '';
    progress = 0;
    title = json['volumeInfo']['title'] ?? 'No title available';
    subtitle = json['volumeInfo']['subtitle'] ?? 'No Subtitle available';
    authors = (json['volumeInfo']['authors'] ?? <String>[]).cast<String>();
    publishedDate = json['volumeInfo']['publishedDate'] ?? 'No Date Available';
    description =
        json['volumeInfo']['description'] ?? 'No Description Available';
    if (json['volumeInfo']['industryIdentifiers'] != null) {
      industryIdentifiers = [];
      json['volumeInfo']['industryIdentifiers'].forEach((v) {
        industryIdentifiers!.add(new IndustryIdentifiers.fromJson(v));
      });
    }
    pageCount = json['volumeInfo']['pageCount'] ?? 0;
    categories =
        (json['volumeInfo']['categories'] ?? <String>[]).cast<String>();
    maturityRating = json['volumeInfo']['maturityRating'];
    smallThumbnail = json['volumeInfo']['imageLinks'] == null
        ? null
        : json['volumeInfo']['imageLinks']['smallThumbnail'];
    thumbnail = json['volumeInfo']['imageLinks'] == null
        ? null
        : json['volumeInfo']['imageLinks']['thumbnail'];
    language = json['volumeInfo']['language'] ?? 'Unknown';
    previewLink = json['volumeInfo']['previewLink'] ?? 'https:www.google.com';
    infoLink = json['volumeInfo']['infoLink'] ?? 'https:www.google.com';
    canonicalVolumeLink =
        json['volumeInfo']['canonicalVolumeLink'] ?? 'https:www.google.com';
    webReaderLink =
        json['accessInfo']['webReaderLink'] ?? 'https:www.google.com';
  }

  APIBook.fromFire(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    etag = json['etag'] ?? '';
    progress = double.tryParse('${json['progress']}');
    title = json['title'] ?? 'No title available';
    subtitle = json['subtitle'] ?? 'No Subtitle available';
    authors = (json['authors'] ?? <String>[]).cast<String>();
    publishedDate = json['publishedDate'] ?? 'No Date Available';
    description = json['description'] ?? 'No Description Available';
    if (json['industryIdentifiers'] != null) {
      industryIdentifiers = [];
      json['industryIdentifiers'].forEach((v) {
        industryIdentifiers!.add(new IndustryIdentifiers.fromJson(v));
      });
    }
    pageCount = json['pageCount'] ?? 0;
    categories = (json['categories'] ?? <String>[]).cast<String>();
    maturityRating = json['maturityRating'];
    smallThumbnail = json['smallThumbnail'];
    thumbnail = json['thumbnail'];
    language = json['language'] ?? 'Unknown';
    previewLink = json['previewLink'] ?? 'https:www.google.com';
    infoLink = json['infoLink'] ?? 'https:www.google.com';
    canonicalVolumeLink = json['canonicalVolumeLink'] ?? 'https:www.google.com';
    webReaderLink = json['webReaderLink'] ?? 'https:www.google.com';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['etag'] = this.etag;
    data['progress'] = progress;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['authors'] = this.authors;
    data['publishedDate'] = this.publishedDate;
    data['description'] = this.description;
    if (this.industryIdentifiers != null) {
      data['industryIdentifiers'] =
          this.industryIdentifiers!.map((v) => v.toJson()).toList();
    }
    data['pageCount'] = this.pageCount;
    data['categories'] = this.categories;
    data['maturityRating'] = this.maturityRating;
    data['smallThumbnail'] = this.smallThumbnail;
    data['thumbnail'] = this.thumbnail;
    data['language'] = this.language;
    data['previewLink'] = this.previewLink;
    data['infoLink'] = this.infoLink;
    data['canonicalVolumeLink'] = this.canonicalVolumeLink;
    data['webReaderLink'] = this.webReaderLink;
    return data;
  }
}

class IndustryIdentifiers {
  String? type;
  String? identifier;

  IndustryIdentifiers({this.type, this.identifier});

  IndustryIdentifiers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    identifier = json['identifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['identifier'] = this.identifier;
    return data;
  }
}
