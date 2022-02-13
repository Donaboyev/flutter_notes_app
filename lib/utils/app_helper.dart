import 'package:flutter/material.dart';

class AppHelper {
  static List<Color> colors = [
    const Color(0xFFFFFFFF),
    const Color(0xffF28B83),
    const Color(0xFFFCBC05),
    const Color(0xFFFFF476),
    const Color(0xFFCBFF90),
    const Color(0xFFA7FEEA),
    const Color(0xFFE6C9A9),
    const Color(0xFFE8EAEE),
    const Color(0xFFA7FEEA),
    const Color(0xFFCAF0F8)
  ];

  static String getPriorityText(int priority) {
    switch (priority) {
      case 2:
        return '!!!';
      case 1:
        return '!!';
      case 0:
        return '!';
      default:
        return '!';
    }
  }

  static Color getPriorityColor(int priority) {
    switch (priority) {
      case 2:
        return Colors.red;
      case 1:
        return Colors.yellow;
      case 0:
        return Colors.green;
      default:
        return Colors.yellow;
    }
  }
}
