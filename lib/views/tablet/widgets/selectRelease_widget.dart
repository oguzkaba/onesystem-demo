import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/controllers/database_controller.dart';
import 'package:onesystem/models/datasource_model.dart';
import 'package:onesystem/models/globals_model.dart';
import 'package:onesystem/models/mysqlQuery_model.dart';
import 'package:onesystem/views/tablet/widgets/dropDown_widget.dart';
import 'package:onesystem/views/tablet/widgets/headBox_widget.dart';

// ignore: must_be_immutable
class SelectRelease extends StatelessWidget {
  SelectRelease({
    Key key,
  }) : super(key: key);

  DatabaseController dbc = Get.put(DatabaseController());
  EmployeeDataSource employeeDataSource;
  dynamic fileno, spoolno, weldno, type = '';

  @override
  Widget build(BuildContext context) {
    int selectedIndex;

    return Column(
      children: [
        //Sol-Ust
        Expanded(
            flex: 1,
            child: Card(
              margin: EdgeInsets.all(2),
              child: Column(
                children: [
                  HeadBoxWidget(title: 'Select Release'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                child: DropDownWidget(
                                    enable: true, title: 'Select List'),
                              )),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(right: 3),
                              height: Get.height / 23,
                              child: ElevatedButton(
                                child: Text('Cancel'),
                                style: ElevatedButton.styleFrom(
                                    primary: Global.medium,
                                    textStyle: TextStyle(fontSize: 12)),
                                onPressed: null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
        //Sol-Alt
        Expanded(
            flex: 8,
            child: Card(
                margin: EdgeInsets.all(2),
                child: Obx(() => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadBoxWidget(
                              title:
                                  'Spool Items (${dbc.listForFileSpool.length.toString()})'), //count eklenecek
                          Expanded(
                              child: RefreshIndicator(
                            onRefresh: () => _refreshData(dbc),
                            child: ListView.separated(
                              padding: EdgeInsets.all(2),
                              itemCount: dbc.listForFileSpool.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    selectedIndex = index;
                                    spoolno = dbc
                                        .listForFileSpool[selectedIndex][1]
                                        .toString();
                                    fileno = dbc.listForFileSpool[selectedIndex]
                                            [0]
                                        .toString();
                                    gettingWeldCopy();
                                  },
                                  tileColor: selectedIndex == index
                                      ? Global.focusedBlue
                                      : null,
                                  selectedTileColor: Global.focusedBlue,
                                  title: Center(
                                      child: Text(
                                          dbc.listForFileSpool[index][0] +
                                              '-' +
                                              dbc.listForFileSpool[index][1]
                                                  .toString(),
                                          style: TextStyle(
                                              color: selectedIndex == index
                                                  ? Global.white
                                                  : null))),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(height: 1);
                              },
                            ),
                          ))
                        ])))),
      ],
    );
  }

  Future<void> _refreshData(DatabaseController dbc) async {
    print('refreshing data...');
    await dbc.getFileNoSpool(query: MysqlQuery().queryList['getFileNoSpool']);
  }

  Future<void> gettingWeldCopy() async {
    await dbc.getWeldCopy(
        selectWF: 'weld',
        fno: fileno,
        sno: spoolno,
        query: MysqlQuery().queryList['getWeld']);
    print(
        'Yüklenen db boyutu (SelectRelease): ${dbc.listForWeldCopy.length.toString()}');
    employeeDataSource = EmployeeDataSource(
      employeeData: dbc.listForWeldCopy,
      listForFields: dbc.listForFields,
    );
  }
}
