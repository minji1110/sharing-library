class KakaoBookSearchModel {
  List<Documents> documents;
  Meta meta;

  KakaoBookSearchModel({this.documents, this.meta});

  KakaoBookSearchModel.fromJson(Map<String, dynamic> json) {
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Documents {
  String title;
  List<String> authors;
  List<String> translators;
  String isbn;
  String contents;
  String datetime;
  String publisher;
  String thumbnail;
  int price;
  int salePrice;
  String status;
  String url;

  Documents(
      {this.title,
      this.authors,
      this.translators,
      this.isbn,
      this.contents,
      this.datetime,
      this.publisher,
      this.thumbnail,
      this.price,
      this.salePrice,
      this.status,
      this.url});

  Documents.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    authors = json['authors'].cast<String>();
    translators = json['translators'].cast<String>();
    isbn = json['isbn'];
    contents = json['contents'];
    datetime = json['datetime'];
    publisher = json['publisher'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    salePrice = json['sale_price'];
    status = json['status'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['authors'] = this.authors;
    data['translators'] = this.translators;
    data['isbn'] = this.isbn;
    data['contents'] = this.contents;
    data['datetime'] = this.datetime;
    data['publisher'] = this.publisher;
    data['thumbnail'] = this.thumbnail;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    data['status'] = this.status;
    data['url'] = this.url;
    return data;
  }
}

class Meta {
  int totalCount;
  int pageableCount;
  bool isEnd;

  Meta({this.totalCount, this.pageableCount, this.isEnd});

  Meta.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    pageableCount = json['pageable_count'];
    isEnd = json['is_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    data['pageable_count'] = this.pageableCount;
    data['is_end'] = this.isEnd;
    return data;
  }
}
