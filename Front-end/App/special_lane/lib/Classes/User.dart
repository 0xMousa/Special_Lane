import 'package:flutter/foundation.dart';
import 'package:special_lane/Classes/classes.dart';

class User extends ChangeNotifier {
  var headers;
  String name, username, email, carNo;
  int points;
  List<dynamic> submisions;
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
    submisions = map['submit'] ?? [];
    notifyListeners();
  }

  addPrise(UserPrise prise) {
    if (notifications['prise'] == null) {
      this.notifications['prise'] = List();
    }
    notifications['prise'].add(prise);
    notifyListeners();
  }
}
