import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/models/globals_model.dart';

class ShowDialogWidget extends StatelessWidget {
  final String title, text1, text2, tbtn1, tbtn2;
  final Function onPressed;

  const ShowDialogWidget(
      {Key key,
      this.title,
      this.text1,
      this.text2,
      this.tbtn1,
      this.tbtn2,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(color: Global.dark_red)),
      content: SingleChildScrollView(
        child: ListBody(children: <Widget>[
          Text(
            text1,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(text2, style: TextStyle(fontSize: 14))
        ]),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            tbtn1,
            style: TextStyle(color: Global.dark_red),
          ),
          onPressed: onPressed,
        ),
        TextButton(
          child: Text(
            tbtn2,
            style: TextStyle(color: Global.black),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
