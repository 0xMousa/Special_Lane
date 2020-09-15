import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/pages.dart';
import 'Util/util.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Special Lane',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: UI.backgroundColor,
      ),
      home: SignUp(),
    );
  }
}
