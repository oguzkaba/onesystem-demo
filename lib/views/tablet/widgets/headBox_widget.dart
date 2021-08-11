import 'package:flutter/material.dart';
import 'package:onesystem/models/globals_model.dart';

class HeadBoxWidget extends StatelessWidget {
  final String title;
  final int height;
  const HeadBoxWidget({Key key, this.title, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Global.medium,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3), topRight: Radius.circular(3))),
        height: height ?? 28,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 2),
        child: Text(title, style: TextStyle(color: Global.white)));
  }
}
