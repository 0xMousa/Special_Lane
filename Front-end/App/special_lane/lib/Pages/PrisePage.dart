import 'package:flutter/material.dart';
import 'package:special_lane/Classes/classes.dart';
import 'package:special_lane/Util/util.dart';

class PrisePage extends StatefulWidget {
  static final id = 'PrisePageId';

  final title;
  final prizes;

  PrisePage({
    @required this.prizes,
    @required this.title,
  });

  @override
  _PrisePageState createState() => _PrisePageState();
}

class _PrisePageState extends State<PrisePage> {
  Prise prise;

  @override
  void initState() {
    super.initState();
    prise = null;
  }

  openPrise(Prise priseToOpen) {
    setState(() {
      prise = priseToOpen;
    });
  }

  done() {
    setState(() {
      prise = null;
    });
  }

  cancel() {
    setState(() {
      prise = null;
    });
  }

  back() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                      children: List.generate(widget.prizes.length, (prise) {
                        return _PriseItem(
                          item: widget.prizes[prise],
                          action: openPrise,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _CustomDialog(
            item: prise,
            action1: cancel,
            action2: done,
            opened: prise != null,
          ),
        ],
      ),
    );
  }
}

class _PriseItem extends StatelessWidget {
  final item;
  final action;

  _PriseItem({
    @required this.item,
    @required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action(item);
      },
      child: Container(
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
                    item.name,
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
                    item.shop +
                        ' / ' +
                        UI.numberFormat(item.points.toString()) +
                        ' Points',
                    style: TextStyle(
                      color: UI.secondaryFontColor,
                      fontSize: UI.fontSize[4],
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: UI.iconSize[3],
                color: UI.primaryFontColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomDialog extends StatefulWidget {
  final item;
  final action1, action2;
  final opened;

  _CustomDialog({
    @required this.item,
    @required this.action1,
    @required this.action2,
    @required this.opened,
  });

  @override
  __CustomDialogState createState() => __CustomDialogState();
}

class __CustomDialogState extends State<_CustomDialog> {
  @override
  Widget build(BuildContext context) {
    if (!widget.opened) {
      return SizedBox();
    }
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.action1,
      child: Container(
        height: size.height,
        width: size.width,
        color: UI.black,
        child: GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              height: 250.0,
              width: 300.0,
              decoration: BoxDecoration(
                color: UI.darkColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.item.name,
                    style: TextStyle(
                      color: UI.primaryFontColor,
                      fontSize: UI.fontSize[1],
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.item.shop +
                            ' - ' +
                            UI.numberFormat(widget.item.points.toString()) +
                            ' Points',
                        style: TextStyle(
                          color: UI.primaryFontColor,
                          fontSize: UI.fontSize[2],
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      Text(
                        'You have 2,000 Points',
                        style: TextStyle(
                          color: UI.secondaryFontColor,
                          fontSize: UI.fontSize[4],
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: widget.action1,
                        child: Container(
                          height: 40.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: UI.primaryFontColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: UI.primaryFontColor,
                                fontSize: UI.fontSize[4],
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.action2,
                        child: Container(
                          height: 40.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            color: UI.primaryFontColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Center(
                            child: Text(
                              'Done',
                              style: TextStyle(
                                color: UI.backgroundColor,
                                fontSize: UI.fontSize[4],
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
