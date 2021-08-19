import 'package:flutter/material.dart';
import 'package:sharing_library/my_home.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 20.0),
        child: TabBarView(
          controller: _tabController,
          children: [MyHome(), Container(), Container(), Container()],
        ),
      ),
      bottomNavigationBar: TabBar(
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.transparent,
        labelPadding: EdgeInsets.only(bottom: 20.0),
        labelColor: Colors.brown,
        tabs: [
          Tab(
              child: Column(
            children: [
              Icon(
                Icons.menu_book_outlined,
              ),
              Text(
                '홈',
                style: TextStyle(fontSize: 12.0),
              )
            ],
          )),
          Tab(
              child: Column(
            children: [
              Icon(
                Icons.favorite_border_outlined,
              ),
              Text(
                '좋아요',
                style: TextStyle(fontSize: 12.0),
              )
            ],
          )),
          Tab(
              child: Column(
            children: [
              Icon(
                Icons.chat_bubble_outline,
              ),
              Text(
                '채팅',
                style: TextStyle(fontSize: 12.0),
              )
            ],
          )),
          Tab(
              child: Column(
            children: [
              Icon(
                Icons.person_outline,
              ),
              Text(
                '내정보',
                style: TextStyle(fontSize: 12.0),
              )
            ],
          )),
        ],
        controller: _tabController,
      ),
    );
  }
}
