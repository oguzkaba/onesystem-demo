import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownWidget extends StatelessWidget {
  final String title, select;
  final Function changed;
  final bool enable, search;
  final List<String> items;
  final Mode mode;

  const DropDownWidget(
      {Key key,
      this.title,
      this.select,
      this.changed,
      this.enable,
      this.items,
      this.mode,
      this.search})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 22,
      child: DropdownSearch(
        maxHeight: Get.height * .6,
        enabled: enable,
        dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0), isDense: true),
        popupTitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        autoValidateMode: AutovalidateMode.always,
        showSearchBox: search ?? true,
        autoFocusSearchBox: true,
        items: items,
        selectedItem: select ?? title,
        onChanged: changed,
        mode: mode ?? Mode.MENU,
      ),
    );
  }
}
