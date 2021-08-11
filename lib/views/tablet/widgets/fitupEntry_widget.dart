import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onesystem/controllers/dataview_controller.dart';
import 'package:onesystem/controllers/theme_controller.dart';
import 'package:onesystem/models/globals_model.dart';
import 'package:onesystem/views/tablet/widgets/borderedContainer_widget.dart';
import 'package:onesystem/views/tablet/widgets/borderedText_widget.dart';
import 'package:onesystem/views/tablet/widgets/dropDown_widget.dart';
import 'package:onesystem/views/tablet/widgets/ebutton_widget.dart';
import 'package:onesystem/views/tablet/widgets/headBox_widget.dart';
import 'package:onesystem/views/tablet/widgets/userNote_widget.dart';

class FitupEntryWidget extends StatefulWidget {
  final String sno, wno, type;
  final List noteList;
  FitupEntryWidget({Key key, this.sno, this.wno, this.type, this.noteList})
      : super(key: key);

  @override
  _FitupEntryWidgetState createState() => _FitupEntryWidgetState();
}

class _FitupEntryWidgetState extends State<FitupEntryWidget>
    with TickerProviderStateMixin {
  void initState() {
    super.initState();
    if (widget.noteList.isNotEmpty) _showDialog();
  }

  _showDialog() async {
    await Future.delayed(Duration(microseconds: 1));
    Get.dialog(UserNoteWidget(noteList: widget.noteList));
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownItems = [];
    for (var i = 0; i < 100; i++)
      if (i < 10) {
        dropdownItems.add('E-00$i');
      } else {
        dropdownItems.add('E-0$i');
      }

    ThemeController tc = Get.put(ThemeController());
    DataviewController dvc = Get.put(DataviewController());

    return WillPopScope(
      onWillPop: () async {
        dvc.selectHeat.value = true;
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: tc.isColorChangeWD(),
          ),
          backgroundColor: tc.isColorChangeDW(),
          centerTitle: true,
          title: Text('OneSystem > Fit-Up Entry',
              style: TextStyle(fontSize: 16, color: tc.isColorChangeWD())),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Card(
                              child: Column(children: [
                            HeadBoxWidget(title: 'Weld Info'),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(children: [
                                Text('Spool No :'),
                                BorderedText(text: widget.sno, leftmargin: 8),
                                Checkbox(value: true, onChanged: (value) {}),
                                Text('Date'),
                                Obx(() => BorderedText(
                                    text: DateFormat("dd-MM-yyyy").format(
                                        DateTime.parse(dvc.selectedDate3.value
                                            .toString())),
                                    leftmargin: 8)),
                                IconButton(
                                    onPressed: () => _selectDate(context, dvc),
                                    icon: Icon(Icons.date_range)),
                                SizedBox(
                                  width: 120,
                                  child: DropDownWidget(
                                    title: 'Select Team',
                                    enable: true,
                                    mode: Mode.MENU,
                                    select: 'E-050',
                                    search: false,
                                    items: dropdownItems,
                                    changed: (value) {
                                      dvc.dropSelectT1.value = value;
                                    },
                                  ),
                                )
                              ]),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(children: [
                                Text('Weld No :'),
                                BorderedText(text: widget.wno, leftmargin: 8),
                                Text('Weld Type :'),
                                BorderedText(text: widget.type, leftmargin: 8)
                              ]),
                            ))
                          ]))),
                      Expanded(
                        flex: 4,
                        child: Card(
                            child: Container(
                                width: Get.width,
                                child: Obx(() => Column(
                                      children: [
                                        HeadBoxWidget(title: 'Fitup Info'),
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(children: [
                                                Expanded(
                                                    child: Text('Stock No: ',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                Expanded(
                                                    flex: 3,
                                                    child: InkWell(
                                                      onTap: () {
                                                        dvc.selectHeat.value =
                                                            true;
                                                      },
                                                      child: BorderedContainer(
                                                          color: dvc.selectHeat
                                                                  .value
                                                              ? Global
                                                                  .light_green
                                                              : Colors
                                                                  .transparent,
                                                          text: ' ',
                                                          height:
                                                              double.infinity),
                                                    )),
                                                Expanded(
                                                    flex: 3,
                                                    child: InkWell(
                                                      onTap: () {
                                                        dvc.selectHeat.value =
                                                            false;
                                                      },
                                                      child: BorderedContainer(
                                                          color: dvc.selectHeat
                                                                  .value
                                                              ? Colors
                                                                  .transparent
                                                              : Global
                                                                  .light_green,
                                                          text: ' ',
                                                          height:
                                                              double.infinity),
                                                    ))
                                              ]),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Row(children: [
                                                  Expanded(
                                                      child: Text('Item No: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Expanded(
                                                      flex: 3,
                                                      child: InkWell(
                                                        onTap: () {
                                                          dvc.selectHeat.value =
                                                              true;
                                                        },
                                                        child: BorderedContainer(
                                                            color: dvc
                                                                    .selectHeat
                                                                    .value
                                                                ? Global
                                                                    .light_green
                                                                : Colors
                                                                    .transparent,
                                                            text: ' ',
                                                            height: double
                                                                .infinity),
                                                      )),
                                                  Expanded(
                                                      flex: 3,
                                                      child: InkWell(
                                                        onTap: () {
                                                          dvc.selectHeat.value =
                                                              false;
                                                        },
                                                        child: BorderedContainer(
                                                            color: dvc
                                                                    .selectHeat
                                                                    .value
                                                                ? Colors
                                                                    .transparent
                                                                : Global
                                                                    .light_green,
                                                            text: ' ',
                                                            height: double
                                                                .infinity),
                                                      ))
                                                ]))),
                                        Expanded(
                                            flex: 4,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Row(children: [
                                                  Expanded(
                                                      child: Text('Heat No: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Expanded(
                                                    flex: 3,
                                                    child: InkWell(
                                                        onTap: () {
                                                          dvc.selectHeat.value =
                                                              true;
                                                        },
                                                        child: BorderedContainer(
                                                            color: dvc
                                                                    .selectHeat
                                                                    .value
                                                                ? Global
                                                                    .light_green
                                                                : Colors
                                                                    .transparent,
                                                            text: ' ',
                                                            height: double
                                                                .infinity)),
                                                  ),
                                                  Expanded(
                                                      flex: 3,
                                                      child: InkWell(
                                                        onTap: () {
                                                          dvc.selectHeat.value =
                                                              false;
                                                        },
                                                        child: BorderedContainer(
                                                            color: dvc
                                                                    .selectHeat
                                                                    .value
                                                                ? Colors
                                                                    .transparent
                                                                : Global
                                                                    .light_green,
                                                            text: ' ',
                                                            height: double
                                                                .infinity),
                                                      ))
                                                ]))),
                                        Expanded(
                                            flex: 1,
                                            child: Row(children: [
                                              Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: EButtonWidget(
                                                    onClick: () {},
                                                    color: Global.dark_red,
                                                    title: 'Clean',
                                                    tcolor: Global.white),
                                              )),
                                              Expanded(
                                                  flex: 6,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8),
                                                    child: EButtonWidget(
                                                        onClick: () {
                                                          Get.back();
                                                          dvc.selectHeat.value =
                                                              true;
                                                        },
                                                        color: Global.medium,
                                                        title: 'Save',
                                                        tcolor: Global.white),
                                                  ))
                                            ]))
                                      ],
                                    )))),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Card(
                      child: Container(
                          height: Get.height,
                          child: Column(
                            children: [
                              HeadBoxWidget(title: 'Select Heat No'),
                              Expanded(child: Text('data')),
                            ],
                          ))))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, DataviewController dvc) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dvc.selectedDate3.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (picked != null) dvc.selectedDate3.value = picked;
  }
}
