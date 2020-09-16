import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:special_lane/Classes/classes.dart';
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
  bool isLoading;
  User user;
  var notifications;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    user = Provider.of<User>(context, listen: false);
    notifications = List();
    user.notifications.forEach((k, v) {
      notifications.add([k], [v]);
    });
    getData();
  }

  getData() {
    setState(() {
      isLoading = false;
    });
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
    return isLoading
        ? Scaffold(
            body: Center(
              child: Loading(),
            ),
          )
        : Scaffold(
            key: scaffoldKey,
            drawer: CustomDrawer(
              pageId: Notifications.id,
              nvigate: nvigate,
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(
                      'You can check all\nyour notifications.',
                      style: TextStyle(
                        color: UI.primaryFontColor,
                        fontSize: UI.fontSize[1],
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Flexible(
                      child: ListView(
                        children: List.generate(notifications.length, (i) {
                          return _Notification(
                            type: notifications[i][0],
                            notification: notifications[i][1],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class _Notification extends StatelessWidget {
  final type;
  final notification;

  _Notification({
    this.type,
    this.notification,
  });

  @override
  Widget build(BuildContext context) {
    if (type == 'prise') {
      return Container(
        padding: EdgeInsets.only(bottom: 24.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.name + ' / ' + notification.shop,
                    style: TextStyle(
                      color: UI.primaryFontColor,
                      fontSize: UI.fontSize[2],
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Code: ' + notification.code,
                    style: TextStyle(
                      color: UI.secondaryFontColor,
                      fontSize: UI.fontSize[4],
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.content_copy,
                size: UI.iconSize[3],
                color: UI.primaryFontColor,
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
