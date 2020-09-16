import 'package:flutter/material.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Util/util.dart';

class WaitingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: UI.buttonHeight,
        child: Center(
          child: Loading(),
        ),
      ),
    );
  }
}
