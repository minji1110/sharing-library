import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenSize {
  static final ScreenSize _instance = ScreenSize._internal();
  Size? mediaSize;
  double? ptWidth;

  factory ScreenSize() {
    return _instance;
  }

  ScreenSize._internal() {
    ptWidth = 375.0;
  }

  setMediaSize(Size size) {
    mediaSize = size;
  }

  double getSize(double inputSize) {
    return (inputSize * mediaSize!.width ~/ ptWidth!).toDouble();
  }
}
