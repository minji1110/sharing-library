import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_library/common/common_text_style.dart';
import 'package:sharing_library/common/screen_size.dart';
import 'package:sharing_library/provider/my_home_provider.dart';

import '../../common/common_color.dart';
import '../../model/book_model.dart';
import 'add_book_view.dart';

class MyHomeView extends StatelessWidget {
  MyHomeView({Key? key}) : super(key: key);

  final ScreenSize screenSize = ScreenSize();
  final userId = 1;
  @override
  Widget build(BuildContext context) {
    Provider.of<MyHomeProvider>(context, listen: false).fetchBookList(userId);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: Container(),
        title: _buildTitle(),
        backgroundColor: lightBrown,
      ),
      body: SafeArea(
        child: Consumer<MyHomeProvider>(builder: (context, provider, child) {
          return provider.initialFetched
              ? Container(
                  // color: Color(0xFFDCD7C9),
                  child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Expanded(child: _buildBookList(context, provider.bookList!))
                  ],
                ))
              : Center(
                  child: CircularProgressIndicator(
                  color: darkBrown,
                ));
        }),
      ),
    );
  }

  _buildTitle() {
    return RichText(
        text: TextSpan(
            text: '김민지',
            style: commonBoldTextStyle(25.0, darkBrown),
            children: [
          TextSpan(
              text: ' 님의 서재', style: commonRegularTextStyle(18.0, darkBrown))
        ]));
  }

  _buildBookList(BuildContext context, List<Book> bookList) {
    return Container(
      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      // color: lightBrown,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonBoldText('전체 ${bookList.length}권', 15, Colors.black),
              Row(
                children: [
                  Icon(Icons.sort),
                  commonRegularText('최신순', 15, Colors.black)
                ],
              )
            ],
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.3),
                    crossAxisCount: 3,
                    crossAxisSpacing: 30.0,
                    mainAxisSpacing: 10.0),
                itemCount: bookList.length + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? _addBookButton(context)
                      : _buildOneBook(context, bookList[index - 1]);
                }),
          ),
        ],
      ),
    );
  }

  _buildOneBook(BuildContext context, Book book) {
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
              book.bookImageUrl!,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        Text(
          book.bookTitle!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: commonBoldTextStyle(12, Colors.black),
        ),
        Text(
          book.bookAuthor!,
          style: commonRegularTextStyle(10, Colors.black),
        )
      ],
    );
  }

  _addBookButton(context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 6.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
                color: Colors.black12,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddBookView()));
                  },
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Colors.grey,
                    size: 40.0,
                  ),
                )),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
      ],
    );
  }
}
