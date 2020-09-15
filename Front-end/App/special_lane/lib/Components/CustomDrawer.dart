import 'package:flutter/material.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Pages/HomePage.dart';
import 'package:special_lane/Pages/pages.dart';
import 'package:special_lane/Util/util.dart';

class CustomDrawer extends StatefulWidget {
  final pageId;
  final nvigate;

  CustomDrawer({
    @required this.pageId,
    @required this.nvigate,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final pageIdToName = {
    HomePage.id: 'Home',
    Notifications.id: 'Notifications',
    UploadPage.id: 'Pictures',
    ProfilePage.id: 'Profile',
  };
  final nameToPageId = {
    'Home': HomePage.id,
    'Notifications': Notifications.id,
    'Pictures': UploadPage.id,
    'Profile': ProfilePage.id,
  };
  final items = ['Home', 'Pictures', 'Notifications', 'Profile'];

  @override
  void initState() {
    super.initState();
  }

  signOut() {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: UI.darkColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(items.length, (item) {
                final name = items[item];
                final color = (name == pageIdToName[widget.pageId]
                    ? UI.pickedColor
                    : UI.darkColor);
                return GestureDetector(
                  onTap: () {
                    widget.nvigate(nameToPageId[name]);
                  },
                  child: _Item(
                    name: name,
                    color: color,
                  ),
                );
              }),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              child: SecondaryButton(
                name: 'Sign out',
                action: signOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final name;
  final color;

  _Item({
    @required this.name,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              color: UI.primaryFontColor,
              fontSize: UI.fontSize[2],
              fontFamily: 'Quicksand',
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: UI.iconSize[3],
            color: UI.primaryFontColor,
          ),
        ],
      ),
    );
  }
}
