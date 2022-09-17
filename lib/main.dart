import 'package:flutter/material.dart';
import 'package:sharing_library/screen/initial_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Sharing Library', home: InitialPage());
  }
}
