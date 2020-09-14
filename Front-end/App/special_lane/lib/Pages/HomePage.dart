import 'package:flutter/material.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Util/util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int points;

  @override
  void initState() {
    super.initState();
    points = 2000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRow(
              child: Icon(
                Icons.menu,
                size: UI.iconSize,
                color: UI.primaryFontColor,
              ),
              index: 0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRow(
                  child: Text(
                    'You have:',
                    style: TextStyle(
                      color: UI.lightSecondaryFontColor,
                      fontSize: UI.fontSize[2],
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  index: 0,
                ),
                SizedBox(
                  height: 12.0,
                ),
                CustomRow(
                  child: Text(
                    UI.numberFormat(points.toString()),
                    style: TextStyle(
                      color: UI.primaryFontColor,
                      fontSize: UI.fontSize[0],
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  index: 1,
                ),
                SizedBox(
                  height: 12.0,
                ),
                CustomRow(
                  child: Text(
                    'Points',
                    style: TextStyle(
                      color: UI.lightSecondaryFontColor,
                      fontSize: UI.fontSize[2],
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  index: 2,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cities',
                    style: TextStyle(
                      color: UI.primaryFontColor,
                      fontSize: UI.fontSize[1],
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: UI.cardHeight * 2,
                    child: ListView(
                      children: [
                        Container(
                          height: UI.cardHeight,
                          width: UI.cardWidth,
                          decoration: BoxDecoration(
                            color: Color(0xFF2DC8ED),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Amman',
                                style: TextStyle(
                                  color: Color(0xFF203F79),
                                  fontSize: UI.fontSize[2],
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                              Text(
                                '+250',
                                style: TextStyle(
                                  color: Color(0xFF203F79),
                                  fontSize: UI.fontSize[2],
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
