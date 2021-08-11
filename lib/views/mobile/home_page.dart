import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/controllers/internet_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';

// ignore: must_be_immutable
class HomePageMobile extends StatelessWidget {
  NetController nc = Get.put(NetController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              child: Center(
                child: Text('Coming Soon'),
              ),
              // child: Row(
              //   children: [
              //     //TabletVerticalNavWidget(),
              //     TabNavWidget(),
              //     Expanded(
              //       child: SingleChildScrollView(
              //         child: BodyContentTabletWidget(
              //           sizingInformation: sizingInformation,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ),
        );
      },
    );
  }
}
