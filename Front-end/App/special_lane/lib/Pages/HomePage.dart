import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:special_lane/Classes/classes.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Pages/pages.dart';
import 'package:special_lane/Util/util.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static final id = 'HomePageId';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int points;
  var cities, violations;
  bool isLoading;
  User user;
  var shops;
  var shopsNames = ['starbucks'];
  var shopPrises;

  @override
  void initState() {
    super.initState();
    user = Provider.of<User>(context, listen: false);
    isLoading = true;
    points = user.points;
    shopPrises = Map<String, dynamic>();
    getData();
    shops = List();
    cities = List();
    violations = List();
    for (int i = 0; i < Things.cities.length; i++) {
      int sum = 0;
      for (int j = 0; j < Things.city[Things.cities[i]].length; j++) {
        sum += int.parse(Things.city[Things.cities[i]][j].points);
      }
      String number;
      if (sum == 0) {
        number = '0';
      } else if (sum > 0) {
        number = '+${sum.toString()}';
      } else {
        number = '-${sum.toString()}';
      }
      cities.add(CardInfo(
        name: Things.cities[i],
        number: number,
      ));
    }
    for (int i = 0; i < Things.prizes.length; i++) {
      violations.add(CardInfo(
        name: Things.prizes[i],
        number: '25',
      ));
    }
  }

  getData() async {
    for (int i = 0; i < shopsNames.length; i++) {
      var respose = await http.get(
        API.shops + '/${shopsNames[i]}',
        headers: user.headers,
      );
      var menu = jsonDecode(respose.body)['menu'];
      setState(() {
        shops.add(
          CardInfo(
            name: shopsNames[i],
            number: menu.length.toString(),
          ),
        );
        for (int j = 0; j < menu.length; j++) {
          if (shopPrises[shopsNames[i]] == null) {
            shopPrises[shopsNames[i]] = List();
          }
          shopPrises[shopsNames[i]].add(
            Prise(
              name: menu[j]['name'],
              shop: shopsNames[i],
              points: menu[j]['point'],
            ),
          );
        }
      });
    }
    for (int i = 0; i < shopsNames.length; i++) {
      var respose = await http.get(
        API.shops + '/${shopsNames[i]}',
        headers: user.headers,
      );
      var menu = jsonDecode(respose.body)['menu'];
      for (int j = 0; j < menu.length; j++) {
        var prise = await http.get(
          API.shops + '/${shopsNames[i]}/${menu[j]['name']}',
          headers: user.headers,
        );
        print(prise.body);
        var priseData = jsonDecode(prise.body);
        for (int k = 0; k < priseData['codes'].length; k++) {
          user.addPrise(
            UserPrise(
              name: menu[j]['name'],
              shop: shopsNames[i],
              code: priseData['codes'][k],
            ),
          );
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  nvigate(String id) {
    scaffoldKey.currentState.openEndDrawer();
    if (id != HomePage.id) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return IdToPage.idToPage(id);
        }),
      );
    }
  }

  cardAction(String title, String name) {
    if (title == 'Prizes') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return PrisePage(
            prizes: shopPrises[name],
            title: name,
          );
        }),
      );
    } else if (title == 'Cities') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return CityPage(
            locations: Things.city[name],
            title: name,
          );
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
              pageId: HomePage.id,
              nvigate: nvigate,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30.0),
                        child: Column(
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
                              height: 20.0,
                            ),
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
                      ),
                      Cards(
                        title: 'Cities',
                        info: cities,
                        backgroundColor: UI.blueGradient,
                        fontColor: UI.blue,
                        action: cardAction,
                      ),
                      Cards(
                        title: 'Prizes',
                        info: shops,
                        backgroundColor: UI.greenGradient,
                        fontColor: UI.green,
                        action: cardAction,
                      ),
                      Cards(
                        title: 'Violations',
                        info: violations,
                        backgroundColor: UI.redGradient,
                        fontColor: UI.red,
                        action: cardAction,
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
