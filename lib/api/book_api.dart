import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sharing_library/api/api_server_info.dart';
import 'package:sharing_library/model/book_model.dart';
import 'package:sharing_library/model/kakao_book_search_model.dart';

import '../model/book_list_model.dart';

final _hostUrl = HOST_URL;

// kakao 책검색
Future<KakaoBookSearchModel> searchBook(String query, int page) async {
  final requestUri = '$_hostUrl/book/search?query=$query&page=$page&size=20';
  final response = await http.get(Uri.parse(requestUri));

  printResult(requestUri, response);

  if (response.statusCode == 200) {
    return KakaoBookSearchModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)));
  } else
    throw Exception('fail');
}

// 사용자별 책 목록 조회
Future<BookListModel?> getBooksByUser(int userId) async {
  final requestUri = '$_hostUrl/books/$userId';
  final response = await http.get(Uri.parse(requestUri));

  printResult(requestUri, response);

  if (response.statusCode == 200) {
    var result = json.decode(utf8.decode(response.bodyBytes));
    if (result['success']) {
      return BookListModel.fromJson(result);
    } else
      return result['message'];
  }
  return null;
}

//책 저장하기
Future<BookModel?> addOneBook(int userId, KakaoSearch kakaoSearch) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  final requestUri = '$_hostUrl/book/$userId';
  final response = await http.post(Uri.parse(requestUri),
      headers: headers, body: json.encode(kakaoSearch));

  printResult(requestUri, response);

  if (response.statusCode == 200) {
    var result = json.decode(utf8.decode(response.bodyBytes));

    if (result['success'])
      return BookModel.fromJson(result);
    else
      return result['message'];
  }
  return null;
}

void printResult(requestUri, response) {
  print('요청: ' + requestUri);
  print('응답: ' + response.statusCode.toString());

  var decoded = const JsonDecoder().convert(utf8.decode(response.bodyBytes));
  var reformatted = const JsonEncoder.withIndent(' ').convert(decoded);
  debugPrint('response body : $reformatted');
}
