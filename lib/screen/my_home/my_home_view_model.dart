import 'package:flutter/cupertino.dart';

class MyHomeViewModel extends ChangeNotifier {
  String? _searchValue;
  String? get searchValue => _searchValue;

  void setSearchValue(String value) {
    _searchValue = value;
    notifyListeners();
  }
}
