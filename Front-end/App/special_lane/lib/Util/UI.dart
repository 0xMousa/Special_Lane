import 'package:flutter/material.dart';

class UI {
  static final backgroundColor = Color(0xFF0B132B);
  static final primaryFontColor = Color(0xFF6FFFE9);
  static final secondaryFontColor = Color(0xFF9CA7B5);
  static final lightSecondaryFontColor = Color(0xFF858995);
  static final pickedColor = Color(0xFF1C2541);
  static final darkColor = Color(0xFF3A506B);
  static final pureGreen = Color(0xFF00FF00);
  static final pureRed = Color(0xFFFF0000);
  static final black = Color(0x64000000);
  static final green = Color(0xFF006155);
  static final blue = Color(0xFF203F79);
  static final red = Color(0xFF6D002A);

  static final blueGradient = LinearGradient(
    colors: [
      Color(0xFF2DC8ED),
      Color(0xFF548AF0),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static final greenGradient = LinearGradient(
    colors: [
      Color(0xFF42DF90),
      Color(0xFF149E8E),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static final redGradient = LinearGradient(
    colors: [
      Color(0xFFF86B64),
      Color(0xFFFA5293),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final fontSize = [50.0, 30.0, 24.0, 20.0, 16.0];
  static final iconSize = [100.0, 40.0, 30.0, 24.0];

  static final buttonHeight = 55.0;

  static final cardHeight = 115.0;
  static final cardWidth = 150.0;

  static final imageHeight = 200.0;
  static final imageWidth = 300.0;

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
