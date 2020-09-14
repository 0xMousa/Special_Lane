import 'package:flutter/material.dart';
import 'package:special_lane/Util/util.dart';

class CustomTextField extends StatelessWidget {
  final action;
  final hint;
  final icon;
  final iconColor;
  final isObscure;

  CustomTextField({
    @required this.action,
    @required this.hint,
    @required this.icon,
    @required this.iconColor,
    @required this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        action(value);
      },
      obscureText: isObscure,
      style: TextStyle(
        color: UI.primaryFontColor,
        fontSize: UI.fontSize[2],
        fontFamily: 'Quicksand',
      ),
      cursorColor: UI.primaryFontColor,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: UI.primaryFontColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: UI.primaryFontColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: UI.primaryFontColor),
        ),
        suffixIcon: Icon(
          icon,
          color: iconColor,
          size: UI.iconSize,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: UI.darkColor,
        ),
      ),
    );
  }
}
