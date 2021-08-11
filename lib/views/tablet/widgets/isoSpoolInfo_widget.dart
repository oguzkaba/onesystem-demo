import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onesystem/controllers/dataview_controller.dart';
import 'package:onesystem/models/globals_model.dart';
import 'package:onesystem/views/tablet/widgets/borderedText_widget.dart';
import 'package:onesystem/views/tablet/widgets/dropDown_widget.dart';
import 'package:onesystem/views/tablet/widgets/eButton_widget.dart';
import 'package:onesystem/views/tablet/widgets/headBox_widget.dart';
import 'package:onesystem/views/tablet/widgets/userNote_widget.dart';

class IsoSpoolInfoWidget extends StatelessWidget {
  final String selectWF;
  final index;
  final dynamic fileno, spoolno;
  final List noteList;
  final dbc;

  const IsoSpoolInfoWidget({
    this.selectWF,
    this.index,
    this.fileno,
    this.spoolno,
    this.noteList,
    this.dbc,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _stateNote() {
      //gelen liste boş veya note aktif değilse gösterme
      if (noteList.isEmpty || noteList.first[3] == 0) {
        return false;
        //gelen liste dolu fakat, diğer kullanıcılara gösterme kapalı ve notu kullanıcı kendi yazmamış ise gösterme
      } else if (noteList.first[2] == 0 &&
          dbc.listForSign.first.id != noteList.first[4]) {
        return false;
        //diğer durumlarda göster
      } else
        return true;
    }

    Map<String, String> dropdownItems = {
      'QC-5': 'KLM NOP',
      'QC-7': 'HIJ AAAA',
      'QC-19': 'DEF ASD',
      'QC-20': 'FG RBV',
      'QC-28': 'ABC DEF',
      'QC-31': 'Oğuz KABA'
    };

    DataviewController dvc = Get.put(DataviewController());

    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Card(
                margin: EdgeInsets.all(2),
                child: Column(children: [
                  HeadBoxWidget(title: 'ISO / Spool Info'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 6,
                              child: Row(children: [
                                Expanded(
                                    flex: 1,
                                    child: Column(children: [
                                      Expanded(
                                          child: Row(children: [
                                        Text('ISO No: '),
                                        BorderedText(text: 'ISO-0001')
                                      ])),
                                      Expanded(
                                          child: Row(children: [
                                        Text('Spool: '),
                                        spoolno == null
                                            ? Text('')
                                            : BorderedText(
                                                text: spoolno, leftmargin: 8),
                                        Text('Active',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Global.green)),
                                        SizedBox(width: 23),
                                        index == -1
                                            ? Container()
                                            : TextButton(
                                                child: Obx(() => Text(
                                                      _stateNote()
                                                          ? 'See Note'
                                                          : '+ Add Note',
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: Global
                                                              .focusedBlue,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                onPressed: () => Get.dialog(
                                                    UserNoteWidget(
                                                        noteList: noteList,
                                                        fno: fileno,
                                                        sno: spoolno)),
                                              ),
                                      ]))
                                    ])),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(children: [
                                      Row(children: [
                                        Text('ISO Rev.: '),
                                        BorderedText(text: '1A', leftmargin: 8),
                                        Text('Active',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Global.green)),
                                        Checkbox(
                                          value: true,
                                          onChanged: (value) {},
                                        ),
                                        Text('Date: '),
                                        Obx(() => BorderedText(
                                            text: selectWF == 'fitup'
                                                ? DateFormat("dd-MM-yyyy")
                                                    .format(DateTime.parse(dvc
                                                        .selectedDate1.value
                                                        .toString()))
                                                : DateFormat("dd-MM-yyyy")
                                                    .format(DateTime.parse(dvc
                                                        .selectedDate2.value
                                                        .toString())),
                                            leftmargin: 8)),
                                        IconButton(
                                            onPressed: () =>
                                                _selectDate(context, dvc),
                                            icon: Icon(Icons.date_range))
                                      ]),
                                      Row(children: [
                                        Text('QC No: '),
                                        BorderedText(
                                            text: 'QC-31', leftmargin: 8),
                                        Expanded(
                                            child: DropDownWidget(
                                          title: 'Select Personnel',
                                          enable: true,
                                          mode: Mode.MENU,
                                          select: 'QC-31',
                                          search: false,
                                          items: dropdownItems.keys.toList(),
                                          changed: (value) {
                                            if (selectWF == 'fitup') {
                                              dvc.dropSelectQ1.value =
                                                  dropdownItems[value];
                                            } else {
                                              dvc.dropSelectQ2.value =
                                                  dropdownItems[value];
                                            }
                                          },
                                        )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 50),
                                            child: Obx(() => Text(
                                                selectWF == 'fitup'
                                                    ? dvc.dropSelectQ1.value
                                                    : dvc.dropSelectQ2.value,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))))
                                      ])
                                    ]),
                                  ),
                                )
                              ])),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: EButtonWidget(
                                      color: Global.green,
                                      title: 'Approve',
                                      onClick: () {
                                        print('Kaydediliyor...');
                                      })))
                        ],
                      ),
                    ),
                  )
                ])))
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, DataviewController dvc) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectWF == 'fitup'
            ? dvc.selectedDate1.value
            : dvc.selectedDate2.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (picked != null) if (selectWF == 'fitup') {
      dvc.selectedDate1.value = picked;
    } else {
      dvc.selectedDate2.value = picked;
    }
  }
}
