import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/models/exporter_model.dart';
import 'package:onesystem/models/globals_model.dart';
import 'package:onesystem/models/mysqlQuery_model.dart';
import 'package:onesystem/views/tablet/widgets/borderedText_widget.dart';

// ignore: must_be_immutable
class UserNoteWidget extends StatelessWidget {
  final List noteList;
  final fno, sno;

  UserNoteWidget({Key key, this.noteList, this.fno, this.sno})
      : super(key: key);
  String user = '';
  var _controller = TextEditingController();
  ThemeController tc = Get.put(ThemeController());
  DataviewController dvc = Get.put(DataviewController());
  DatabaseController dbc = Get.put(DatabaseController());

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

    return AlertDialog(
        title: Text(_stateNote() == true ? 'See Note' : '+ Add Note',
            style: TextStyle(color: Global.focusedBlue, fontSize: 18)),
        content: Container(
            width: 600,
            child: _stateNote() == true ? _seeNoteShow() : _addNoteShow()),
        actions: _stateNote()
            ? <Widget>[
                TextButton(
                    child: Text(
                      'CLOSE',
                      style: TextStyle(color: Global.dark_red, fontSize: 16),
                    ),
                    onPressed: () {
                      Get.back();
                    })
              ]
            : [
                Obx(() => Container(
                    width: 500,
                    child: Row(children: [
                      Checkbox(
                          activeColor: Global.green,
                          value: dvc.checkValue.value,
                          onChanged: (value) => dvc.checkValue.value = value),
                      Text('Make this note visible to all users',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]))),
                TextButton(
                    child: Text(
                      'OK',
                      style: TextStyle(color: Global.green, fontSize: 16),
                    ),
                    onPressed: () async {
                      int _vsb;
                      String _fsno;
                      _fsno = fno + "-" + sno;
                      if (dvc.checkValue.value)
                        _vsb = 1;
                      else
                        _vsb = 0;
                      await dbc.addNoteUser(
                          query: MysqlQuery().queryList['addNoteUser'],
                          note: _controller.text,
                          visibility: _vsb,
                          active: 1,
                          uid: dbc.listForSign.first.id,
                          fsno: _fsno);
                    }),
                TextButton(
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Global.black, fontSize: 16),
                    ),
                    onPressed: () {
                      Get.back();
                    })
              ]);
  }

  Column _seeNoteShow() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BorderedText(
            text: noteList.first[1].toString(), weight: FontWeight.normal),
        Row(children: [
          Text('Author: '),
          Text(dbc.listForNoteByUser.first[1].toString().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold)),
          dbc.listForSign.first.id == noteList.first[4]
              ? Obx(() => Container(
                  width: 450,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Checkbox(
                        activeColor: Global.green,
                        value: dvc.checkValue.value,
                        onChanged: (value) => dvc.checkValue.value = value),
                    Text('Make your note passive',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])))
              : Text(''),
        ])
      ],
    );
  }

  TextField _addNoteShow() {
    return TextField(
        controller: _controller,
        minLines: 5,
        maxLength: 400,
        maxLines: null,
        decoration: InputDecoration(
          suffixIcon: TextButton(
            onPressed: _controller.clear,
            child: Text(
              'Clear',
              style: TextStyle(color: Global.dark_red, fontSize: 16.0),
            ),
          ),
          labelStyle: TextStyle(
              color: tc.isSavedDarkMode() ? Global.white : Global.dark_default,
              fontSize: 18.0),
          focusColor: Global.focusedBlue,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Global.extra_light, width: 1.3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Global.focusedBlue, width: 1.3),
          ),
          labelText: 'Please write your note...',
        ),
        obscureText: false);
  }
}
