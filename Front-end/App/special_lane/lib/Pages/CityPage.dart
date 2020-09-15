import 'package:flutter/material.dart';
import 'package:special_lane/Util/util.dart';

class CityPage extends StatefulWidget {
  static final id = 'CityPageId';

  final title;
  final locations;

  CityPage({
    @required this.title,
    @required this.locations,
  });

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  @override
  void initState() {
    super.initState();
  }

  back() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 30.0,
            top: 40.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: back,
                    child: Icon(
                      Icons.arrow_back,
                      size: UI.iconSize[3],
                      color: UI.primaryFontColor,
                    ),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: UI.primaryFontColor,
                      fontSize: UI.fontSize[2],
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_back,
                    size: UI.iconSize[3],
                    color: UI.backgroundColor,
                  ),
                ],
              ),
              Flexible(
                child: ListView(
                  children: List.generate(widget.locations.length, (location) {
                    return _LocationItem(
                      item: widget.locations[location],
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

class _LocationItem extends StatelessWidget {
  final item;

  _LocationItem({
    @required this.item,
  });

  @override
  Widget build(BuildContext context) {
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
                  item.location,
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
                  item.date,
                  style: TextStyle(
                    color: UI.secondaryFontColor,
                    fontSize: UI.fontSize[4],
                    fontFamily: 'Quicksand',
                  ),
                ),
              ],
            ),
            Text(
              item.points,
              style: TextStyle(
                color: (item.points[0] == '+' ? UI.pureGreen : UI.pureRed),
                fontSize: UI.fontSize[2],
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
