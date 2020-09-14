import 'package:flutter/material.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Util/util.dart';

class ProfilePage extends StatefulWidget {
  static final id = 'ProfilePageID';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  String name, username, email, carNumber;
  bool isObscure;

  @override
  void initState() {
    super.initState();
    name = 'Something Anything';
    username = 'something_funny';
    email = 'something@gmail.com';
    carNumber = '2458734';
    isObscure = true;
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

  save() {}
  signOut() {}

  openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(
        page: 'Profile',
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        alignment: Alignment.bottomLeft,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CustomRow(
                    child: GestureDetector(
                      onTap: openDrawer,
                      child: Icon(
                        Icons.menu,
                        size: UI.iconSize,
                        color: UI.primaryFontColor,
                      ),
                    ),
                    index: 0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomContainer(),
                ],
              ),
              SizedBox(
                height: 35.0,
              ),
              CustomTextField(
                action: nameInput,
                hint: 'Name',
                icon: Icons.done,
                iconColor:
                    (name.length == 0 ? UI.darkColor : UI.primaryFontColor),
                isObscure: false,
                initialValue: name,
              ),
              CustomTextField(
                action: usernameInput,
                hint: 'Username',
                icon: Icons.done,
                iconColor:
                    (username.length == 0 ? UI.darkColor : UI.primaryFontColor),
                isObscure: false,
                initialValue: username,
              ),
              CustomTextField(
                action: emailInput,
                hint: 'Email',
                icon: Icons.done,
                iconColor:
                    (!email.contains('@') ? UI.darkColor : UI.primaryFontColor),
                isObscure: false,
                initialValue: email,
              ),
              CustomTextField(
                action: carNumberInput,
                hint: 'Car Number',
                icon: Icons.done,
                iconColor: (carNumber.length == 0
                    ? UI.darkColor
                    : UI.primaryFontColor),
                isObscure: false,
                initialValue: carNumber,
              ),
              SizedBox(
                height: 30.0,
              ),
              PrimaryButton(
                name: 'Save',
                action: save,
              ),
              SizedBox(
                height: 30.0,
              ),
              SecondaryButton(
                name: 'Sign out',
                action: signOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
