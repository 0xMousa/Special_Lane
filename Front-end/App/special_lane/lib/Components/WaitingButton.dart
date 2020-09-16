import 'package:flutter/material.dart';
import 'package:special_lane/Util/util.dart';

class WaitingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: UI.buttonHeight,
        child: Center(
          child: Container(
            height: UI.buttonHeight * 0.75,
            width: UI.buttonHeight * 0.75,
            child: CircularProgressIndicator(
              backgroundColor: UI.darkColor,
              valueColor: AlwaysStoppedAnimation<Color>(UI.primaryFontColor),
            ),
          ),
        ),
      ),
    );
  }
}
