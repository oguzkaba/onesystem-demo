import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EButtonWidget extends StatelessWidget {
  final String title;
  final Color color;
  final Color tcolor;
  final Function onClick;
  final double width;
  final double height;

  const EButtonWidget(
      {Key key,
      this.title,
      this.color,
      this.onClick,
      this.height,
      this.width,
      this.tcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .06,
      width: Get.width * .3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          //shadowColor: Colors.transparent,
          primary: color,
        ),
        onPressed: onClick,
        child: Text(title, style: TextStyle(color: tcolor, fontSize: 18)),
      ),
    );
  }
}
