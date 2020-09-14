import 'package:flutter/material.dart';
import 'package:special_lane/Components/components.dart';
import 'package:special_lane/Util/util.dart';

class PrisePage extends StatefulWidget {
  static final id = 'PrisePageId';

  final prizes;

  PrisePage({
    @required this.prizes,
  });

  @override
  _PrisePageState createState() => _PrisePageState();
}

class _PrisePageState extends State<PrisePage> {
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
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRow(
                child: GestureDetector(
                  onTap: back,
                  child: Icon(
                    Icons.arrow_back,
                    size: UI.iconSize,
                    color: UI.primaryFontColor,
                  ),
                ),
                index: 0,
              ),
              ListView(
                children: List.generate(widget.prizes.length, (prise) {
                  return Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                widget.prizes[prise].name,
                                style: TextStyle(
                                  color: UI.primaryFontColor,
                                  fontSize: UI.fontSize[2],
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
