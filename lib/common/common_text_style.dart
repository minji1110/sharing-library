import 'package:flutter/material.dart';

final mainFont = 'GowunDodum';

Text commonRegularText(String text, double fontSize, Color color) {
  return Text(text, style: commonRegularTextStyle(fontSize, color));
}

TextStyle commonRegularTextStyle(double fontSize, Color color) {
  return TextStyle(fontSize: fontSize, color: color, fontFamily: mainFont);
}

Text commonBoldText(String text, double fontSize, Color color) {
  return Text(text, style: commonBoldTextStyle(fontSize, color));
}

TextStyle commonBoldTextStyle(double fontSize, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      fontFamily: mainFont,
      color: color);
}
