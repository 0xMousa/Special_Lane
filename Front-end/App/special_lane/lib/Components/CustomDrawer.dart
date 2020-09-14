import 'package:flutter/material.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Pages/HomePage.dart';
import 'package:special_lane/Pages/pages.dart';
import 'package:special_lane/Util/util.dart';

class CustomDrawer extends StatefulWidget {
  final page;

  CustomDrawer({
    @required this.page,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final items = [
    {
      'id': HomePage.id,
      'name': 'Home',
    },
    {
      'id': 'id',
      'name': 'Pictures',
    },
    {
      'id': 'id',
      'name': 'Notifications',
    },
    {
      'id': ProfilePage.id,
      'name': 'Profile',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  nvigate(String pageId) {
    print(pageId);
    if (pageId == HomePage.id && widget.page != 'Home') {
      Navigator.pop(context);
    } else if (pageId != HomePage.id && widget.page == 'Home') {
      Navigator.pushNamed(context, pageId);
    } else if (pageId != HomePage.id && widget.page != 'Home') {
      Navigator.pushReplacementNamed(context, pageId);
    } else {}
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
                final name = items[item]['name'];
                final color =
                    (name == widget.page ? UI.pickedColor : UI.darkColor);
                return GestureDetector(
                  onTap: () {
                    nvigate(items[item]['id']);
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
            size: UI.iconSize,
            color: UI.primaryFontColor,
          ),
        ],
      ),
    );
  }
}
