import 'package:onesystem/models/exporter_model.dart';
import 'package:get/get.dart';
import 'package:onesystem/models/datasource_model.dart';
import 'package:onesystem/views/tablet/widgets/datagrid_widget.dart';
import 'package:onesystem/views/tablet/widgets/headBox_widget.dart';
import 'package:onesystem/views/tablet/widgets/navHead_widget.dart';
import 'package:onesystem/views/tablet/widgets/releaseInfo_widget.dart';
import 'package:onesystem/views/tablet/widgets/releasedSpool_widget.dart';
import 'package:onesystem/views/tablet/widgets/selectRelease_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReleasePage extends StatefulWidget {
  @override
  _ReleasePageState createState() => _ReleasePageState();
}

class _ReleasePageState extends State<ReleasePage>
    with AutomaticKeepAliveClientMixin<ReleasePage> {
  DataviewController dvc = Get.put(DataviewController());
  ThemeController tc = Get.put(ThemeController());
  DatabaseController dbc = Get.put(DatabaseController());
  EmployeeDataSource employeeDataSource;
  DataGridController _dataGridController;

  dynamic fileno, spoolno = '';

  @override
  void initState() {
    print('ReleasePage initsate');
    super.initState();
  }

  @override
  void dispose() {
    print('ReleasePage dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: tc.isColorChangeDW(),
            centerTitle: true,
            title: NavHeadWidget(title: 'Release Page'),
            toolbarHeight: 25),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(children: [
            //Sol kolon
            Expanded(
              flex: 1,
              child:
                  //Sol kolonu 2 ye böl...
                  SelectRelease(),
            ),
            //Orta kolon
            Expanded(
              flex: 3,
              child:
                  //Orta kolonu 2 ye böl...
                  Column(
                children: [
                  //Orta-Ust
                  Expanded(
                      flex: 2,
                      child: Card(
                        margin: EdgeInsets.all(2),
                        child: ReleaseInfo(),
                      )),
                  //Orta-Alt
                  Expanded(
                      flex: 7,
                      child: Obx(() => Card(
                            margin: EdgeInsets.all(2),
                            child: dbc.listForWeldCopy.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Center(
                                            child: Icon(Icons.view_list_rounded,
                                                size: 50)),
                                        Text(
                                            'To see the list, select a spool number from the spool list field')
                                      ])
                                : DataGridWidget(
                                    controller: _dataGridController,
                                    colName: Global.listsWeld,
                                    title: 'Weld List',
                                    openDialog: false,
                                    dataSource: gettingReleaseList(
                                        dbc.listForWeldCopy)),
                          )))
                ],
              ),
            ),
            //Sağ kolon
            Expanded(
              flex: 1,
              child:
                  //Sağ kolonu 2 ye böl...
                  Column(
                children: [
                  //Sağ-Ust
                  Expanded(flex: 4, child: ReleasedSpoolWidget()),
                  //Sağ-Alt
                  Expanded(
                      flex: 1,
                      child: Card(
                        margin: EdgeInsets.all(2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HeadBoxWidget(title: 'Change Released Condition'),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 5),
                                    height: Get.height / 13,
                                    width: Get.width / 13,
                                    child: ElevatedButton(
                                      child: Text('Release'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Global.medium,
                                      ),
                                      onPressed: () {},
                                    )),
                                Container(
                                    height: Get.height / 13,
                                    width: Get.width / 13,
                                    child: ElevatedButton(
                                        child: Text('Cancel Release',
                                            textAlign: TextAlign.center),
                                        style: ElevatedButton.styleFrom(
                                          primary: Global.dark_red,
                                        ),
                                        onPressed: null))
                              ],
                            ))
                          ],
                        ),
                      ))
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  gettingReleaseList(value) {
    return employeeDataSource = EmployeeDataSource(
        employeeData: value, listForFields: dbc.listForFields);
  }
}
