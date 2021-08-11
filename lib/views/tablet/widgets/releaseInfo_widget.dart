import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/models/globals_model.dart';
import 'package:onesystem/views/tablet/widgets/borderedText_widget.dart';
import 'package:onesystem/views/tablet/widgets/headBox_widget.dart';

class ReleaseInfo extends StatelessWidget {
  const ReleaseInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        HeadBoxWidget(title: 'Spool Release Info'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ISO No: '),
                            BorderedText(text: 'ISO-0001', leftmargin: 4),
                            Text('Active',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Global.green)),
                            Container(
                                margin: EdgeInsets.only(right: 6),
                                //width: 80,
                                height: Get.height * .04,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Global.dark_red,
                                    ),
                                    onPressed: null,
                                    child: Text('Add Problem',
                                        maxLines: 2,
                                        textAlign: TextAlign.center)))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Rev.No : '),
                            BorderedText(text: '2A'),
                            Text('PED Category : '),
                            BorderedText(text: '1'),
                            Text('Paint Code : '),
                            BorderedText(text: 'PC-123')
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('View DWG : '),
                            Container(
                                height: Get.height * .04,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Global.medium,
                                    ),
                                    onPressed: () {},
                                    child: Text('See Isometric',
                                        maxLines: 2,
                                        textAlign: TextAlign.center))),
                            SizedBox(width: 20),
                            Container(
                                margin: EdgeInsets.only(right: 6),
                                height: Get.height * .04,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Global.medium,
                                    ),
                                    onPressed: () {},
                                    child: Text('See Original',
                                        maxLines: 2,
                                        textAlign: TextAlign.center)))
                          ])
                    ])),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: Get.height / 10,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Global.green,
                          ),
                          onPressed: () {},
                          child: Text('Release Spool',
                              maxLines: 2, textAlign: TextAlign.center)),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  addProblem() {
    Get.defaultDialog(
        barrierDismissible: false,
        title: 'Adding Problem Dialog',
        cancel: ElevatedButton(
            onPressed: () => Get.back(), child: Text('Close Dialog')));
  }
}
