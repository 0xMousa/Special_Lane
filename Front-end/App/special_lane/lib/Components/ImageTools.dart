import 'package:flutter/material.dart';
import 'package:special_lane/Util/util.dart';

class ImageTools extends StatelessWidget {
  final clear;
  final edit;
  final done;

  ImageTools({
    @required this.clear,
    @required this.edit,
    @required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 250.0,
      decoration: BoxDecoration(
        color: UI.primaryFontColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: clear,
              child: Icon(
                Icons.close,
                color: UI.darkColor,
                size: UI.iconSize[2],
              ),
            ),
            GestureDetector(
              onTap: edit,
              child: Icon(
                Icons.settings,
                color: UI.darkColor,
                size: UI.iconSize[2],
              ),
            ),
            GestureDetector(
              onTap: done,
              child: Icon(
                Icons.done,
                color: UI.darkColor,
                size: UI.iconSize[2],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
