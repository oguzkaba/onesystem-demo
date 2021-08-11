import 'package:flutter/material.dart';
import 'package:onesystem/views/desktop/home_page.dart';
import 'package:onesystem/views/mobile/home_page.dart';
import 'package:onesystem/views/tablet/home_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context,sizingInformation){
        if (sizingInformation.isDesktop){
          return HomePageDesktop();
        }
        if (sizingInformation.isTablet){
          return HomePageTablet();
        }
        return HomePageMobile();
      },
    );
  }
}
