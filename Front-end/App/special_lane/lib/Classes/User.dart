import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  var headers;
  String name, username, email, carNo;

  User({
    this.headers,
    this.name,
    this.username,
    this.email,
    this.carNo,
  });

  User fromJson(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      username: map['username'],
      email: map['email'],
      carNo: map['carNo'] ?? '',
    );
  }

  setHeaders(headers) {
    this.headers = headers;
    notifyListeners();
  }
}
