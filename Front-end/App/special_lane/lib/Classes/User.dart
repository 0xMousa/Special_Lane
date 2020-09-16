import 'package:flutter/foundation.dart';
import 'package:special_lane/Classes/classes.dart';

class User extends ChangeNotifier {
  var headers;
  String name, username, email, carNo;
  int points;
  Map<String, dynamic> notifications;

  setHeaders(headers) {
    this.headers = headers;
    notifyListeners();
  }

  getDate(Map<String, dynamic> map) {
    name = map['name'];
    username = map['username'];
    email = map['email'];
    carNo = map['carNo'] ?? '';
    points = map['points'] ?? 0;
    notifyListeners();
  }

  addPrise(UserPrise prise) {
    if (notifications == null) {
      notifications = Map();
    }
    if (notifications['prise'] == null) {
      this.notifications['prise'] = List();
    }
    notifications['prise'].add(prise);
    notifyListeners();
  }

  addPoints() {
    this.points += 20;
    notifyListeners();
  }

  subtractPoints() {
    this.points -= 20;
    notifyListeners();
  }
}
