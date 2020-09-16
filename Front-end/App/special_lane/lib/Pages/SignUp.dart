import 'package:flutter/material.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Pages/pages.dart';
import 'package:special_lane/Util/util.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name, username, email, carNumber, password;
  bool isObscure, isLoading;
  Response response;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    name = '';
    username = '';
    email = '';
    carNumber = '';
    password = '';
    isObscure = true;
    isLoading = false;
  }

  logIn() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return LogIn();
      }),
    );
  }

  signUp() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.post(
      API.register,
      body: {
        'name': name,
        'username': username,
        'email': email,
        'carNo': carNumber,
        'pass': password,
      },
    );
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return LogIn();
        }),
      );
    }
  }

  nameInput(String input) {
    setState(() {
      name = input;
    });
  }

  usernameInput(String input) {
    setState(() {
      username = input;
    });
  }

  emailInput(String input) {
    setState(() {
      email = input;
    });
  }

  carNumberInput(String input) {
    setState(() {
      carNumber = input;
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
                'Create\nAccount.',
                style: TextStyle(
                  color: UI.primaryFontColor,
                  fontSize: UI.fontSize[1],
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              CustomTextField(
                action: nameInput,
                hint: 'Name',
                icon: Icons.done,
                iconColor:
                    (name.length == 0 ? UI.darkColor : UI.primaryFontColor),
                isObscure: false,
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
                action: emailInput,
                hint: 'Email',
                icon: Icons.done,
                iconColor:
                    (!email.contains('@') ? UI.darkColor : UI.primaryFontColor),
                isObscure: false,
              ),
              CustomTextField(
                action: carNumberInput,
                hint: 'Car Number',
                icon: Icons.done,
                iconColor: (carNumber.length == 0
                    ? UI.darkColor
                    : UI.primaryFontColor),
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
                height: 30.0,
              ),
              Container(
                child: isLoading
                    ? WaitingButton()
                    : PrimaryButton(
                        name: 'Sign up',
                        action: signUp,
                      ),
              ),
              SizedBox(
                height: 30.0,
              ),
              SecondaryButton(
                name: 'Log in',
                action: logIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
