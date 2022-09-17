class BookModel {
  bool? success;
  int? code;
  String? message;
  Book? data;

  BookModel({this.success, this.code, this.message, this.data});

  BookModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Book.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Book {
  dynamic createdDate;
  dynamic modifiedDate;
  int? bookId;
  String? bookIsbn;
  String? bookTitle;
  String? bookAuthor;
  String? bookSummary;
  int? bookScore;
  dynamic bookStartDt;
  dynamic bookEndDt;
  String? bookImageUrl;

  Book(
      {this.createdDate,
      this.modifiedDate,
      this.bookId,
      this.bookIsbn,
      this.bookTitle,
      this.bookAuthor,
      this.bookSummary,
      this.bookScore,
      this.bookStartDt,
      this.bookEndDt,
      this.bookImageUrl});

  Book.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
    bookId = json['bookId'];
    bookIsbn = json['bookIsbn'];
    bookTitle = json['bookTitle'];
    bookAuthor = json['bookAuthor'];
    bookSummary = json['bookSummary'];
    bookScore = json['bookScore'];
    bookStartDt = json['bookStartDt'];
    bookEndDt = json['bookEndDt'];
    bookImageUrl = json['bookImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    data['bookId'] = this.bookId;
    data['bookIsbn'] = this.bookIsbn;
    data['bookTitle'] = this.bookTitle;
    data['bookAuthor'] = this.bookAuthor;
    data['bookSummary'] = this.bookSummary;
    data['bookScore'] = this.bookScore;
    data['bookStartDt'] = this.bookStartDt;
    data['bookEndDt'] = this.bookEndDt;
    data['bookImageUrl'] = this.bookImageUrl;
    return data;
  }
}
