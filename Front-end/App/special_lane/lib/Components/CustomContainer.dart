import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final child;

  CustomContainer({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: 0.523,
          child: Container(
            height: 180.0,
            width: 180.0,
            decoration: BoxDecoration(
              color: Color(0xFF484E60),
              borderRadius: BorderRadius.circular(65.0),
            ),
          ),
        ),
        Transform.rotate(
          angle: 1.047,
          child: Container(
            height: 180.0,
            width: 180.0,
            decoration: BoxDecoration(
              color: Color(0xFF858995),
              borderRadius: BorderRadius.circular(65.0),
            ),
          ),
        ),
        Container(
          height: 160.0,
          width: 160.0,
          decoration: BoxDecoration(
            color: Color(0xFF6FFFE9),
            borderRadius: BorderRadius.circular(65.0),
          ),
        ),
        Container(
          child: child ?? Container(),
        ),
      ],
    );
  }
}
