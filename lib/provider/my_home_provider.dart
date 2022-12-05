import 'package:flutter/cupertino.dart';
import 'package:sharing_library/api/book_api.dart';
import 'package:sharing_library/model/book_list_model.dart';

import '../model/book_model.dart';
import '../model/kakao_book_search_model.dart';

class MyHomeProvider extends ChangeNotifier {
  final int _size = 20;

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

  // ==================== kakao

  KakaoBookSearchModel? _kakaoBookSearchModel;
  KakaoBookSearchModel? get kakaoBookSearchModel => _kakaoBookSearchModel;

  List<KakaoSearch>? _kakaoSearchList;
  List<KakaoSearch>? get kakaoSearchList => _kakaoSearchList;

  int? _currPage = 1;
  int? get currPage => _currPage;

  bool _isEnd = true;
  bool get isEnd => _isEnd;

  bool _searchTapped = false;
  bool get searchTapped => _searchTapped;

  bool _isFetched = false;
  bool get isFetched => _isFetched;

  void onSearchTapped(String searchValue) async {
    if (searchValue.isNotEmpty) {
      _searchTapped = true;
      notifyListeners();

      _isFetched = false;
      _currPage = 1;

      KakaoBookSearchModel model = await searchBook(searchValue, _currPage!);
      _kakaoBookSearchModel = model;
      _kakaoSearchList = _kakaoBookSearchModel?.documents;

      _isEnd = _kakaoBookSearchModel!.meta!.totalCount! <= _size * _currPage!;

      print('isEnd= $_isEnd');

      _isFetched = true;
      notifyListeners();
    }
  }

  void fetchMoreData(searchValue) async {
    if (!_isEnd) {
      _currPage = _currPage! + 1;
      KakaoBookSearchModel model = await searchBook(searchValue, _currPage!);
      _kakaoBookSearchModel = model;

      _isEnd = _kakaoBookSearchModel!.meta!.totalCount! <= _size * _currPage!;

      print('isEnd= $_isEnd');

      for (KakaoSearch book in _kakaoBookSearchModel!.documents!) {
        _kakaoSearchList!.add(book);
      }
      notifyListeners();
    }
  }

  // ================ addBook
  BookModel? _addedBook;
  BookModel? get addedBook => _addedBook;

  void addBook(userId, KakaoSearch book) async {
    BookModel? model = await addOneBook(userId, book);
    _addedBook = model;

    notifyListeners();
  }
}
