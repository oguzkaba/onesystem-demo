import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/models/globals_model.dart';
import 'package:onesystem/views/tablet/widgets/borderedText_widget.dart';

class ISOInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Row(
          children: [
            Expanded(flex: 1, child: Text('Condition :')),
            Expanded(
                flex: 1, child: BorderedText(text: 'On Going', leftmargin: 6)),
            Expanded(
                flex: 2,
                child: Text('Passive',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Global.dark_red)))
          ],
        ),
        Row(
          children: [
            Expanded(flex: 1, child: Text('Pipe Class :')),
            Expanded(
                flex: 1, child: BorderedText(text: 'Class-1', leftmargin: 6)),
            Expanded(
                flex: 2,
                child: Text('Mat. - CS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.indigo)))
          ],
        ),
        Row(
          children: [
            Expanded(flex: 1, child: Text('PED Category :')),
            Expanded(flex: 1, child: BorderedText(text: '1', leftmargin: 6)),
            Expanded(flex: 2, child: Container())
          ],
        ),
        Row(
          children: [
            Expanded(flex: 1, child: Text('Paint Code :')),
            Expanded(
                flex: 1, child: BorderedText(text: 'PC-123', leftmargin: 6)),
            Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Container(
                    height: Get.height / 27,
                    child: ElevatedButton.icon(
                        icon: Icon(Icons.file_download),
                        style: ElevatedButton.styleFrom(
                          primary: Global.medium,
                        ),
                        onPressed: () {},
                        label: Text('Download Folder')),
                  ),
                ))
          ],
        ),
        Row(
          children: [
            Expanded(flex: 2, child: Text('View DWG :')),
            Expanded(
                flex: 3,
                child: Container(
                  height: Get.height / 27,
                  margin: EdgeInsets.fromLTRB(6, 0, 3, 3),
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.picture_as_pdf),
                      style: ElevatedButton.styleFrom(
                        primary: Global.medium,
                      ),
                      onPressed: () {
                        Get.toNamed('t/widgets/pdfviewer_widget');
                      },
                      label: Text('Original',
                          style: TextStyle(color: Global.white))),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  height: Get.height / 27,
                  margin: EdgeInsets.fromLTRB(6, 0, 6, 3),
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.picture_as_pdf),
                      style: ElevatedButton.styleFrom(
                        primary: Global.medium,
                      ),
                      onPressed: null,
                      label: Text('Scanned',
                          style: TextStyle(color: Global.white))),
                ))
          ],
        ),
      ]),
    );
  }
}
