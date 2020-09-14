import 'package:flutter/material.dart';
import 'package:special_lane/Util/util.dart';

class SecondaryButton extends StatelessWidget {
  final name;
  final action;

  SecondaryButton({
    @required this.name,
    @required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        height: UI.buttonHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: UI.primaryFontColor,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: UI.primaryFontColor,
              fontSize: UI.fontSize[2],
              fontFamily: 'Quicksand',
            ),
          ),
        ),
      ),
    );
  }
}
