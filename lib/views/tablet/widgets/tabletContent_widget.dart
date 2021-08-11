import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/controllers/page_controller.dart';
import 'package:onesystem/views/tablet/NDT_page.dart';
import 'package:onesystem/views/tablet/approval_page.dart';
import 'package:onesystem/views/tablet/main_page.dart';
import 'package:onesystem/views/tablet/material_page.dart';
import 'package:onesystem/views/tablet/release_page.dart';
import 'package:onesystem/views/tablet/shipping_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BodyContentTabletWidget extends StatelessWidget {
  final SizingInformation sizingInformation;
  final List<Widget> pages = [
    MainPage(),
    MaterialsPage(),
    ApprovalPage(),
    NDTPage(),
    ReleasePage(),
    ShippingPage()
    //SettingsPage(),
  ];
  BodyContentTabletWidget({Key key, this.sizingInformation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PagesController pc = Get.put(PagesController());
    return Container(
      width: Get.width / 1.4,
      height: Get.height / 1.03,
      child: PageView(
        controller: pc.controller,
        physics: NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}
