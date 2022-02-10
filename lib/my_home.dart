import 'package:flutter/material.dart';

import 'api/book_api.dart';
import 'model/kakao_book_search_model.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  String _searchValue;

  _searchBook(String title) {
    Future<KakaoBookSearchModel> searchedBooks = searchBook(title);
  }

  var list = [
    Documents(
        authors: ["기시미이치로"],
        title: "미움받을 용기",
        thumbnail:
            "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038"),
    Documents(
        authors: ["기시미이치로"],
        title: "강아지 키우기",
        thumbnail: "https://picsum.photos/id/237/200/300"),
    Documents(
        authors: ["기시미이치로"],
        title: "미움받을 용기 제목 길어질때 예시",
        thumbnail:
            "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038"),
    Documents(
        authors: ["기시미이치로"],
        title: "미움받을 용기",
        thumbnail:
            "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038"),
    Documents(
        authors: ["기시미이치로"],
        title: "미움받을 용기",
        thumbnail:
            "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038"),
    Documents(
        authors: ["기시미이치로"],
        title: "미움받을 용기",
        thumbnail:
            "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038"),
    Documents(
        authors: ["기시미이치로"],
        title: "미움받을 용기",
        thumbnail:
            "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038"),
    Documents(
        authors: ["기시미이치로"],
        title: "미움받을 용기",
        thumbnail:
            "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038"),
    Documents(
        authors: ["기시미이치로"],
        title: "미움받을 용기",
        thumbnail:
            "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038"),
  ];

  @override
  void initState() {
    super.initState();
    _searchValue = _textController.value.text;
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown.shade400,
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: [
                  _buildTitle(),
                  SizedBox(height: 20.0),
                  Expanded(child: _buildBookList())
                ],
              )),
        ));
  }

  _buildTitle() {
    return Container(
      child: Column(
        children: [
          RichText(
              text: TextSpan(
                  text: '김민지',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'GowunDodum',
                    color: Colors.brown.shade900,
                  ),
                  children: [
                TextSpan(
                    text: ' 님의 서재',
                    style: TextStyle(fontSize: 18.0, fontFamily: 'GowunDodum'))
              ])),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonTextStyle('전체 ${list.length}권'),
              Row(
                children: [Icon(Icons.sort), commonTextStyle('최신순')],
              )
            ],
          )
        ],
      ),
    );
  }

  _buildBookList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.3),
            crossAxisCount: 3,
            crossAxisSpacing: 30.0,
            mainAxisSpacing: 10.0),
        itemCount: list.length + 1,
        itemBuilder: (context, index) {
          return index == 0 ? _addBookButton() : _buildOneBook(index);
        });
  }

  _addBookButton() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 6.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
                color: Colors.grey.withOpacity(0.7),
                child: InkWell(
                  onTap: _showSearchDialog,
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Colors.black,
                    size: 40.0,
                  ),
                )),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        // Text('책 추가하기',
        //     style: TextStyle(
        //         fontSize: 12.0,
        //         fontWeight: FontWeight.w700,
        //         fontFamily: 'GowunDodum'))
      ],
    );
  }

  _buildOneBook(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 6.5,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(3.0, 0.0),
                  blurRadius: 3.0)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              list[index - 1].thumbnail,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        Text(
          list[index - 1].title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'GowunDodum'),
        ),
        Text(
          list[index - 1].authors[0],
          style: TextStyle(fontSize: 10.0, fontFamily: 'GowunDodum'),
        )
      ],
    );
  }

  _showSearchDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Container(
                height: 500,
                child: Column(children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        _textController.clear();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        onChanged: (value) {
                          setState(() {
                            _searchValue = value;
                            print('검색어 : $_searchValue');
                          });
                        },
                        decoration: InputDecoration(
                          // suffixIcon: Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     IconButton(
                          //       onPressed: () {
                          //         print('검색!');
                          //       },
                          //       // constraints: BoxConstraints(),
                          //       icon: Icon(
                          //         Icons.search,
                          //         color: Colors.brown,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.brown, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.brown, width: 2.0)),
                          // contentPadding: EdgeInsets.all(10),
                        ),
                      ))
                ]),
              ));
        });
  }

  commonTextStyle(String text) {
    return Text(text,
        style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'GowunDodum'));
  }
}
