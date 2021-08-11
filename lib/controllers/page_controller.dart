import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagesController extends GetxController {
  final _pageindex = 0.obs;
  final PageController controller = PageController();

  int get pindex => _pageindex.value;

  set pindex(int value) => _pageindex.value = value;

  void savedIndex(int value) {
    _pageindex.value = value;
    update();
  }

  void pageindex(int value) {
    controller.jumpToPage(value);
  }
}
