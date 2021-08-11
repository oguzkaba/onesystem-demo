import 'package:flutter/material.dart';
import 'package:onesystem/models/globals_model.dart';

class BorderedContainer extends StatelessWidget {
  final String text;
  final double leftmargin, height;
  final Color color;
  const BorderedContainer({
    @required this.text,
    this.leftmargin,
    this.height,
    this.color,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.fromLTRB(leftmargin ?? 0, 6, 6, 6),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Global.light), color: color),
        child: Center(
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold))));
  }
}
