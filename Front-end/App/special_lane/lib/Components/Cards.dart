import 'package:flutter/material.dart';
import 'package:special_lane/Util/util.dart';

class Cards extends StatelessWidget {
  final title;
  final info;
  final fontColor;
  final backgroundColor;

  Cards({
    @required this.title,
    @required this.info,
    @required this.fontColor,
    @required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(left: 30.0),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: UI.primaryFontColor,
              fontSize: UI.fontSize[1],
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(
          height: UI.cardHeight,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(info.length + 1, (index) {
              if (index == 0) {
                return SizedBox(
                  width: 30.0,
                );
              }
              return _Card(
                name: info[index - 1].name,
                number: info[index - 1].number,
                fontColor: fontColor,
                backgroundColor: backgroundColor,
              );
            }),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final name, number;
  final fontColor;
  final backgroundColor;

  _Card({
    @required this.name,
    @required this.number,
    @required this.fontColor,
    @required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UI.cardHeight,
      width: UI.cardWidth,
      margin: EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        gradient: backgroundColor,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            name,
            style: TextStyle(
              color: fontColor,
              fontSize: UI.fontSize[2],
              fontFamily: 'Quicksand',
            ),
          ),
          Text(
            number,
            style: TextStyle(
              color: fontColor,
              fontSize: UI.fontSize[2],
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
