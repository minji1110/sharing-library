import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sharing_library/api/api_server_info.dart';
import 'package:sharing_library/model/kakao_book_search_model.dart';

final _hostUrl = HOST_URL;

//카카오 api를 이용한 책검색
final _kakaoHost = KAKAO_HOST;
final _searchUri = SEARCH_URI;
final _kakaoAuth = KAKAO_AUTH;

Future<KakaoBookSearchModel> searchBook(String target, String query) async {
  final requestUri = '$_kakaoHost$_searchUri?target=$target&query=$query';
  final response = await http
      .get(Uri.parse(requestUri), headers: {'Authorization': _kakaoAuth});

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    return KakaoBookSearchModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)));
  } else
    throw Exception('fail');
}

//유저별 책 조회
