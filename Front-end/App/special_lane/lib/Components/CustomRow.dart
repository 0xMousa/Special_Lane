import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final child;
  final index;

  CustomRow({
    @required this.child,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(3, (i) {
        if (i == index) {
          return Container(
            child: child,
          );
        }
        return Container();
      }),
    );
  }
}
