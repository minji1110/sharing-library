import 'package:sharing_library/model/book_model.dart';

class BookListModel {
  bool? success;
  int? code;
  String? message;
  List<Book>? dataList;

  BookListModel({this.success, this.code, this.message, this.dataList});

  BookListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['dataList'] != null) {
      dataList = <Book>[];
      json['dataList'].forEach((v) {
        dataList?.add(new Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.dataList != null) {
      data['dataList'] = this.dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
