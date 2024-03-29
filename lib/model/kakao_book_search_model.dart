class KakaoBookSearchModel {
  List<KakaoSearch>? documents;
  Meta? meta;

  KakaoBookSearchModel({this.documents, this.meta});

  KakaoBookSearchModel.fromJson(Map<String, dynamic> json) {
    if (json['documents'] != null) {
      documents = <KakaoSearch>[];
      json['documents'].forEach((v) {
        documents?.add(new KakaoSearch.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class KakaoSearch {
  String? title;
  List<String>? authors;
  List<String>? translators;
  String? isbn;
  String? contents;
  String? datetime;
  String? publisher;
  String? thumbnail;
  int? price;
  int? salePrice;
  String? status;
  String? url;

  KakaoSearch(
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

  KakaoSearch.fromJson(Map<String, dynamic> json) {
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
  int? totalCount;
  int? pageableCount;
  bool? end;

  Meta({this.totalCount, this.pageableCount, this.end});

  Meta.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    pageableCount = json['pageable_count'];
    end = json['_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    data['pageable_count'] = this.pageableCount;
    data['_end'] = this.end;
    return data;
  }
}
