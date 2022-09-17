import 'package:flutter/cupertino.dart';
import 'package:sharing_library/api/book_api.dart';
import 'package:sharing_library/model/book_list_model.dart';

import '../model/book_model.dart';

class MyHomeProvider extends ChangeNotifier {
  BookListModel? _bookListModel;
  BookListModel? get bookListModel => _bookListModel;

  List<Book>? _bookList;
  List<Book>? get bookList => _bookList;

  int? _totalLength;
  int? get totalLength => _totalLength;

  bool _initialFetched = false;
  bool get initialFetched => _initialFetched;

  void fetchBookList(int userId) async {
    BookListModel? model = await getBooksByUser(userId);
    _bookListModel = model;
    _bookList = _bookListModel?.dataList;
    _totalLength = _bookList?.length;
    _initialFetched = true;

    notifyListeners();
  }
}
