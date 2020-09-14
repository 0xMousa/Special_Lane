import 'package:flutter/material.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Util/util.dart';

class WelcomePage extends StatelessWidget {
  logIn() {}
  signUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Special Lane',
              style: TextStyle(
                color: UI.primaryFontColor,
                fontSize: UI.fontSize[1],
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              'Help your community in\nreduce traffic jams.',
              style: TextStyle(
                color: UI.secondaryFontColor,
                fontSize: UI.fontSize[3],
                fontFamily: 'Quicksand',
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            PrimaryButton(
              name: 'Log in',
              action: logIn,
            ),
            SizedBox(
              height: 12.0,
            ),
            SecondaryButton(
              name: 'Sign up',
              action: signUp,
            ),
          ],
        ),
      ),
    );
  }
}
