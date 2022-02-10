import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sharing_library/api/api_server_info.dart';
import 'package:sharing_library/model/kakao_book_search_model.dart';

final _hostUrl = HOST_URL;

//책검색 api
Future<KakaoBookSearchModel> searchBook(String title) async {
  final requestUri = '$_hostUrl/book/search?title=$title';
  final response = await http.get(Uri.parse(requestUri));

  print('요청: ' + requestUri);
  print('응답: ' + response.statusCode.toString());
  print(json.decode(utf8.decode(response.bodyBytes)));

  if (response.statusCode == 200) {
    return KakaoBookSearchModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)));
  } else
    throw Exception('fail');
}
