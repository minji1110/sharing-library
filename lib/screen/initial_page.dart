import 'package:flutter/material.dart';
import 'package:sharing_library/common/common_color.dart';
import 'package:sharing_library/common/common_text_style.dart';

import 'main_tab_bar.dart';

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
              SizedBox(height: 20.0),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainTabBar()));
                  },
                  child: commonBoldText('내 서재로 이동하기', 20.0, lightBrown)),
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
