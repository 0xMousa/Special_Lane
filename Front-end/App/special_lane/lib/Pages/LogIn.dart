import 'package:flutter/material.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Util/util.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String username, password;
  bool isObscure;

  @override
  void initState() {
    super.initState();
    username = '';
    password = '';
    isObscure = true;
  }

  logIn() {}
  signUp() {}

  usernameInput(String input) {
    setState(() {
      username = input;
    });
  }

  passwordInput(String input) {
    setState(() {
      password = input;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        alignment: Alignment.bottomLeft,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome\nBack.',
                style: TextStyle(
                  color: UI.primaryFontColor,
                  fontSize: UI.fontSize[1],
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 230.0,
              ),
              CustomTextField(
                action: usernameInput,
                hint: 'Username',
                icon: Icons.done,
                iconColor:
                    (username.length == 0 ? UI.darkColor : UI.primaryFontColor),
                isObscure: false,
              ),
              CustomTextField(
                action: passwordInput,
                hint: 'Password',
                icon: (isObscure ? Icons.remove_red_eye : Icons.remove_red_eye),
                iconColor: (!isObscure || password.length == 0
                    ? UI.darkColor
                    : UI.primaryFontColor),
                isObscure: isObscure,
              ),
              SizedBox(
                height: 8.0,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: UI.lightSecondaryFontColor,
                    fontSize: UI.fontSize[4],
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              PrimaryButton(
                name: 'Log in',
                action: logIn,
              ),
              SizedBox(
                height: 30.0,
              ),
              SecondaryButton(
                name: 'Sign up',
                action: signUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
