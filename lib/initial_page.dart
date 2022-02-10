import 'package:flutter/material.dart';

import 'my_page.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_outlined,
                size: 150.0,
                color: Colors.brown,
              ),
              Container(
                child: Column(children: [
                  Text(
                    'SHARING',
                    style: _mainFontStyle(),
                  ),
                  Text(
                    'LIBRARY',
                    style: _mainFontStyle(),
                  ),
                ]),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyPage()));
                },
                child: Text(
                  '내 서재로 이동하기',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _mainFontStyle() {
    return TextStyle(
        fontSize: 50.0,
        fontFamily: 'IndieFlower',
        fontWeight: FontWeight.bold,
        color: Colors.brown);
  }
}
