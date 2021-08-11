import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/controllers/sharpref_controller.dart';
import 'package:onesystem/controllers/theme_controller.dart';
import 'package:onesystem/models/exporter_model.dart';

// ignore: must_be_immutable
class NavHeadWidget extends StatelessWidget {
  NavHeadWidget({Key key, @required this.title}) : super(key: key);

  final String title;

  SharedPrefController sc = Get.put(SharedPrefController());
  ThemeController tc = Get.put(ThemeController());
  DataviewController dvc = Get.put(DataviewController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(
        'OneSystem > $title ( Project: ${sc.prjName == null ? dvc.choseProject.toLowerCase() : sc.prjName.toUpperCase()} )',
        /*kullanilacak basliklar icin proje ismini pref den al*/
        style: TextStyle(fontSize: 16, color: tc.isColorChangeWD())));
  }
}
