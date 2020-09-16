import 'package:flutter/material.dart';
import 'package:special_lane/Util/util.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: UI.buttonHeight * 0.75,
      width: UI.buttonHeight * 0.75,
      child: CircularProgressIndicator(
        backgroundColor: UI.darkColor,
        valueColor: AlwaysStoppedAnimation<Color>(UI.primaryFontColor),
      ),
    );
  }
}
