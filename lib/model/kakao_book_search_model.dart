class KakaoBookSearchModel {
  Meta meta;
  List<Documents> documents; //검색결과 리스트

  KakaoBookSearchModel({this.meta, this.documents});

  KakaoBookSearchModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  bool isEnd; //마지막페이지인지
  int pageableCount; //노출가능 책 수
  int totalCount; //검색된 책 수

  Meta({this.isEnd, this.pageableCount, this.totalCount});

  Meta.fromJson(Map<String, dynamic> json) {
    isEnd = json['is_end'];
    pageableCount = json['pageable_count'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_end'] = this.isEnd;
    data['pageable_count'] = this.pageableCount;
    data['total_count'] = this.totalCount;
    return data;
  }
}

class Documents {
  List<String> authors;
  String contents;
  String datetime;
  String isbn;
  int price;
  String publisher;
  int salePrice;
  String status;
  String thumbnail;
  String title;
  List<String> translators;
  String url;

  Documents(
      {this.authors,
      this.contents,
      this.datetime,
      this.isbn,
      this.price,
      this.publisher,
      this.salePrice,
      this.status,
      this.thumbnail,
      this.title,
      this.translators,
      this.url});

  Documents.fromJson(Map<String, dynamic> json) {
    authors = json['authors'].cast<String>();
    contents = json['contents'];
    datetime = json['datetime'];
    isbn = json['isbn'];
    price = json['price'];
    publisher = json['publisher'];
    salePrice = json['sale_price'];
    status = json['status'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    translators = json['translators'].cast<String>();
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authors'] = this.authors;
    data['contents'] = this.contents;
    data['datetime'] = this.datetime;
    data['isbn'] = this.isbn;
    data['price'] = this.price;
    data['publisher'] = this.publisher;
    data['sale_price'] = this.salePrice;
    data['status'] = this.status;
    data['thumbnail'] = this.thumbnail;
    data['title'] = this.title;
    data['translators'] = this.translators;
    data['url'] = this.url;
    return data;
  }
}
