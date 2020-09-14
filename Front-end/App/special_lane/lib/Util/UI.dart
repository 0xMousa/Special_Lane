import 'package:flutter/material.dart';

class UI {
  static final backgroundColor = Color(0xFF0B132B);
  static final primaryFontColor = Color(0xFF6FFFE9);
  static final secondaryFontColor = Color(0xFF9CA7B5);
  static final lightSecondaryFontColor = Color(0xFF858995);
  static final darkColor = Color(0xFF3A506B);

  static final fontSize = [50.0, 32.0, 24.0, 20.0, 16.0];
  static final iconSize = 24.0;

  static final buttonHeight = 55.0;
  static final cardHeight = 120.0;
  static final cardWidth = 70.0;

  static numberFormat(String number) {
    String res = '';
    int length = number.length;
    number = number.split('').reversed.join();
    for (int i = 0; i < length; i++) {
      res += number[i];
      if (i != length - 1 && i != 0 && i % 3 == 2) {
        res += ',';
      }
    }
    res = res.split('').reversed.join();
    return res;
  }
}
