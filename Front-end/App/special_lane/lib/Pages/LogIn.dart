import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:special_lane/Classes/classes.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Pages/pages.dart';
import 'package:special_lane/Util/util.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String username, password;
  bool isObscure, isLoading;
  Map<String, String> headers;
  User user;

  @override
  void initState() {
    super.initState();
    username = '';
    password = '';
    isObscure = true;
    isLoading = false;
    headers = {};
    user = Provider.of<User>(context, listen: false);
  }

  Future<Map> post(String url, dynamic data) async {
    http.Response response = await http.post(url, body: data, headers: headers);
    updateCookie(response);
    return json.decode(response.body);
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    print(rawCookie);
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
    user.setHeaders(headers);
  }

  logIn() async {
    setState(() {
      isLoading = true;
    });
    await post(
      API.login,
      {
        'user': 'admin',
        'pass': 'admin',
      },
    );
    var userData = await http.get(
      // API.users + '/$username',
      API.users + '/admin',
      headers: user.headers,
    );
    user.getDate(jsonDecode(userData.body));
    // var respose = await http.put(
    //   API.shops + '/starbucks/cafe Latte',
    //   headers: user.headers,
    // );
    // print(respose.body);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return HomePage();
      }),
    );
  }

  signUp() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return SignUp();
      }),
    );
  }

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
              Container(
                child: isLoading
                    ? WaitingButton()
                    : PrimaryButton(
                        name: 'Log in',
                        action: logIn,
                      ),
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
