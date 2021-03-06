import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:special_lane/Classes/classes.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Util/util.dart';

class ProfilePage extends StatefulWidget {
  static final id = 'ProfilePageId';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  String name, username, email, carNumber;
  bool isObscure;
  User user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<User>(context, listen: false);
    name = user.name;
    username = user.username;
    email = user.email;
    carNumber = user.carNo;
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

  nvigate(String id) {
    scaffoldKey.currentState.openEndDrawer();
    if (id != ProfilePage.id) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return IdToPage.idToPage(id);
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(
        pageId: ProfilePage.id,
        nvigate: nvigate,
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
                        size: UI.iconSize[3],
                        color: UI.primaryFontColor,
                      ),
                    ),
                    index: 0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomContainer(
                    child: Icon(
                      Icons.camera,
                      size: UI.iconSize[0],
                      color: UI.darkColor,
                    ),
                  ),
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
