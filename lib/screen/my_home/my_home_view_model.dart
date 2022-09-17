import 'package:flutter/cupertino.dart';
import 'package:sharing_library/api/book_api.dart';
import 'package:sharing_library/model/kakao_book_search_model.dart';

import '../../model/kakao_book_search_model.dart';

class MyHomeViewModel extends ChangeNotifier {
  String? _searchValue;
  String? get searchValue => _searchValue;

  KakaoBookSearchModel? _kakaoBookSearchModel;
  KakaoBookSearchModel? get kakaoBookSearchModel => _kakaoBookSearchModel;

  List<KakaoSearch>? _kakaoSearchList;
  List<KakaoSearch>? get kakaoSearchList => _kakaoSearchList;

  int? _page = 0;
  int? get page => _page;

  bool? _isEnd = false;
  bool? get isEnd => _isEnd;

  bool _searchTapped = false;
  bool get searchTapped => _searchTapped;

  bool _isFetched = false;
  bool get isFetched => _isFetched;

  void setSearchValue(String value) {
    _searchValue = value;
    print('search : $_searchValue');
    notifyListeners();
  }

  void onSearchTapped() async {
    if (_searchValue != null && _searchValue!.isNotEmpty) {
      _searchTapped = true;
      notifyListeners();

      _isFetched = false;

      KakaoBookSearchModel model = await searchBook(_searchValue!);
      _kakaoBookSearchModel = model;
      _kakaoSearchList = _kakaoBookSearchModel?.documents;

      _isEnd = _kakaoBookSearchModel?.meta?.isEnd;
      _page = _kakaoBookSearchModel?.meta?.pageableCount;

      _isFetched = true;
      notifyListeners();
    }
  }
}
