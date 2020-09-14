import 'package:flutter/material.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Pages/pages.dart';
import 'package:special_lane/Util/util.dart';

class Notifications extends StatefulWidget {
  static final id = 'NotificationsPageId';

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  nvigate(String id) {
    scaffoldKey.currentState.openEndDrawer();
    if (id == HomePage.id) {
      Navigator.pop(context);
    } else if (id != Notifications.id) {
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
        pageId: Notifications.id,
        nvigate: nvigate,
      ),
    );
  }
}
