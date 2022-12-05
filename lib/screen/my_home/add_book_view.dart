import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_library/common/common_color.dart';
import 'package:sharing_library/common/common_text_style.dart';
import 'package:sharing_library/common/screen_size.dart';
import 'package:sharing_library/screen/my_home/my_home_view_model.dart';

import '../../model/kakao_book_search_model.dart';
import '../../provider/my_home_provider.dart';

class AddBookView extends StatelessWidget {
  AddBookView({Key? key}) : super(key: key);
  final ScreenSize screenSize = ScreenSize();
  final userId = 1;

  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyHomeProvider()),
        ChangeNotifierProvider(create: (context) => MyHomeViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: commonBoldText('책 추가하기', 20.0, Colors.black),
          backgroundColor: lightBrown,
          elevation: 0.0,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode focusScopeNode = FocusScope.of(context);
            if (!focusScopeNode.hasPrimaryFocus &&
                focusScopeNode.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
            _focusNode.unfocus();
          },
          child: Container(
            padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Column(
              children: [
                _searchSection(),
                Expanded(child: _searchResultSection())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchSection() {
    return Consumer2<MyHomeViewModel, MyHomeProvider>(
        builder: (context, viewModel, provider, child) {
      return Container(
        margin: EdgeInsets.only(top: 8.0),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(32),
        ),
        child: TextField(
          controller: _textEditingController,
          focusNode: _focusNode,
          onChanged: (value) => viewModel.setSearchValue(value),
          onSubmitted: (value) => provider.onSearchTapped(value),
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 14),
            hintText: '책 제목, 작가, isbn 으로 검색할 수 있습니다.',
            suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  provider.onSearchTapped(_textEditingController.value.text);
                  _focusNode.unfocus();
                }),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
          ),
        ),
      );
    });
  }

  Widget _searchResultSection() {
    return Consumer<MyHomeProvider>(builder: (context, provider, child) {
      return provider.isFetched
          // 검색 완료
          ? (provider.kakaoSearchList!.isNotEmpty
              ? Container(
                  child: Column(children: [
                    _totalCountText(
                        provider.kakaoBookSearchModel!.meta!.totalCount!),
                    Expanded(
                        child: _buildSearchBookList(
                            context, provider.kakaoSearchList!))
                  ]),
                )
              : Center(
                  child: commonBoldText('검색 결과가 없습니다.', 20.0, Colors.black38),
                ))
          // 검색중 or nothing
          : provider.searchTapped
              ? Center(
                  child: CircularProgressIndicator(
                  color: darkBrown,
                ))
              : Center(
                  child: commonBoldText(
                      '원하는 책을 검색해 내 서재에 추가해보세요 :)', 16.0, Colors.black38));
    });
  }

  Widget _buildSearchBookList(
      BuildContext context, List<KakaoSearch> bookList) {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        print('load more');
        Provider.of<MyHomeProvider>(context, listen: false)
            .fetchMoreData(_textEditingController.value.text);
      }
    });

    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        KakaoSearch book = bookList[index];
        return Column(children: [
          SizedBox(height: 5.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
                padding: EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 8.0, right: 8.0),
                color: Colors.white60,
                height: 170.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        book.thumbnail!,
                        width: 100.0,
                        height: 150.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title!,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF534340),
                                fontWeight: FontWeight.w700,
                                fontFamily: mainFont),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            book.authors!.length > 1
                                ? '${book.authors![0]}외${book.authors!.length - 1} 명 '
                                : book.authors![0],
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Color(0xFF534340),
                                fontFamily: mainFont),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            book.contents!,
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Color(0xFF534340),
                                fontFamily: mainFont),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 10.0,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<MyHomeProvider>(context,
                                        listen: false)
                                    .addBook(userId, book);
                                _showDialog(context, book);
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  primary: lightBrown,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                              child: Text(
                                '추가하기',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
          Container(height: 1.0, color: lightBrown),
        ]);
      },
      itemCount: bookList.length,
    );
  }

  Widget _totalCountText(int totalCount) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
      alignment: Alignment.centerLeft,
      child:
          commonBoldText(' $totalCount 건의 검색결과가 있습니다.', 13.0, Colors.black38),
    );
  }

  _showDialog(BuildContext context, KakaoSearch book) {
    MyHomeProvider provider =
        Provider.of<MyHomeProvider>(context, listen: false);

    return showDialog(
        context: context,
        builder: (context2) {
          return ChangeNotifierProvider.value(
              value: provider, child: _alterDialog(context));
        });
  }

  _alterDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: new Container(
        width: 320.0,
        height: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: commonBoldText('책을 다 읽었나요?', 22.0, Colors.black)),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120.0,
                  height: 100.0,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      primary: darkBrown,
                      side: BorderSide(color: darkBrown, width: 4),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonBoldText('다 읽었어요!', 16.0, darkBrown),
                        SizedBox(height: 5.0),
                        commonRegularText('책 평가 화면으로\n이동합니다.', 12.0, darkBrown)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 120.0,
                  height: 100.0,
                  child: TextButton(
                    onPressed: () {
                      // Provider.of<MyHomeProvider>(context,listen: false).fetchBookList(userId);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      primary: darkBrown,
                      side: BorderSide(color: Colors.grey, width: 4),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonBoldText('아직이요!', 16.0, Colors.grey),
                        SizedBox(height: 5.0),
                        commonRegularText('내 서재에\n저장됩니다.', 12.0, Colors.grey)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
