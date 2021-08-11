import 'package:get/get.dart';
import 'package:onesystem/models/exporter_model.dart';
import 'package:onesystem/models/datasource_model.dart';
import 'package:onesystem/models/mysqlQuery_model.dart';
import 'package:onesystem/views/tablet/widgets/datagrid_widget.dart';
import 'package:onesystem/views/tablet/widgets/dropdown_widget.dart';
import 'package:onesystem/views/tablet/widgets/headBox_widget.dart';
import 'package:onesystem/views/tablet/widgets/isoInfo_widget.dart';
import 'package:onesystem/views/tablet/widgets/navHead_widget.dart';
import 'package:onesystem/views/tablet/widgets/popupMenu_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  DataviewController dvc = Get.put(DataviewController());
  ThemeController tc = Get.put(ThemeController());
  DatabaseController dbc = Get.put(DatabaseController());
  EmployeeDataSource employeeDataSource1, employeeDataSource2;
  final DataGridController _dataGridController = DataGridController();

  dynamic fileno, spoolno = '';

  @override
  void initState() {
    gettingFile();
    print('MainPage initsate');
    super.initState();
  }

  @override
  void dispose() {
    print('MainPage dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    super.build(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: tc.isColorChangeDW(),
            centerTitle: true,
            title: NavHeadWidget(
                title: 'Main Page'), //NavHeadWidget(title: 'Main Page'),
            toolbarHeight: 25),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GetX<DataviewController>(
            builder: (_) => Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Card(
                                margin: EdgeInsets.all(2),
                                child: Column(
                                  children: [
                                    HeadBoxWidget(title: 'Search Isometric'),
                                    Container(
                                      width: Get.width,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Radio(
                                                value: 0,
                                                groupValue:
                                                    dvc.radioValue.value,
                                                onChanged: (value) => dvc
                                                    .radioValue.value = value,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 9,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              alignment: Alignment.centerLeft,
                                              child: DropDownWidget(
                                                select: fileno,
                                                enable:
                                                    dvc.radioValue.value == 0
                                                        ? true
                                                        : false,
                                                title: 'Select Iso NO',
                                                changed: (value) {
                                                  gettingSpool(value);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Radio(
                                                value: 1,
                                                groupValue:
                                                    dvc.radioValue.value,
                                                onChanged: (value) => dvc
                                                    .radioValue.value = value,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: DropDownWidget(
                                                items: dbc.listForFile.cast(),
                                                select: fileno,
                                                enable:
                                                    dvc.radioValue.value == 1
                                                        ? true
                                                        : false,
                                                title: 'Select File NO',
                                                changed: (value) =>
                                                    gettingSpool(value)),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                'Rev. : 1A',
                                                style: TextStyle(
                                                    color: Global.focusedBlue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Card(
                                margin: EdgeInsets.all(2),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadBoxWidget(
                                        title: 'Isometric Information'),
                                    ISOInfoWidget()
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Card(
                          margin: EdgeInsets.all(2),
                          child: dbc.listForSpool.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Center(
                                          child: Icon(Icons.view_list_rounded,
                                              size: 50)),
                                      Text(
                                          'To see the list, select a file number from the isometric search field')
                                    ])
                              : DataGridWidget(
                                  controller: _dataGridController,
                                  colName: Global.listsSpool,
                                  title: 'Spool List',
                                  openDialog: false,
                                  dataSource: employeeDataSource1,
                                  tapFunc: (value) => gettingWeld(value),
                                  longPressFunc: (value) =>
                                      gettingContextMenu(value),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    margin: EdgeInsets.all(2),
                    child: dbc.listForWeld.isEmpty
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
                            dataSource: employeeDataSource2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> gettingFile() async {
    await dbc.getFileNO(query: MysqlQuery().queryList['getFileNO']);
  }

  Future<void> gettingSpool(fno) async {
    dbc.listForWeld.clear();
    setState(() {
      fileno = fno;
    });
    if (fileno != '' || fileno != null) {
      await dbc.getSpool(fno: fno, query: MysqlQuery().queryList['getSpool']);
    } else {
      await null;
    }

    print(dbc.listForFields.length.toString() +
        'Yüklenen db buytu: ${dbc.listForSpool.length.toString()}');
    employeeDataSource1 = EmployeeDataSource(
        employeeData: dbc.listForSpool, listForFields: dbc.listForFields);
  }

  Future<void> gettingWeld(DataGridCellTapDetails details) async {
    if (details.rowColumnIndex.rowIndex != 0) {
      spoolno = dbc.listForSpool[details.rowColumnIndex.rowIndex - 1]['spool']
          .toString();
      print('Seçilen file-spool: ' +
          fileno.toString() +
          '-' +
          spoolno.toString());
      await dbc.getWeld(
          fno: fileno, sno: spoolno, query: MysqlQuery().queryList['getWeld']);
      print('Yüklenen db buytu: ${dbc.listForWeld.length.toString()}');
      employeeDataSource2 = EmployeeDataSource(
        employeeData: dbc.listForWeld,
        listForFields: dbc.listForFields,
      );
    }
  }

  Future<void> gettingContextMenu(DataGridCellLongPressDetails details) async {
    var position = details.globalPosition;
    var _count = 0;
    if (details.rowColumnIndex.rowIndex != 0) {
      spoolno = dbc.listForSpool[details.rowColumnIndex.rowIndex - 1]['spool']
          .toString();
      final RenderBox overlay = Overlay.of(context).context.findRenderObject();

      showMenu(
              context: context,
              items: <PopupMenuEntry<int>>[ContextMenuAction()],
              position: RelativeRect.fromRect(
                  position & const Size(40, 40), // smaller rect, the touch area
                  Offset.zero & overlay.size // Bigger rect, the entire screen
                  ))
          // This is how you handle user selection
          .then<void>((int delta) {
        // delta would be null if user taps on outside the popup menu
        // (causing it to close without making selection)
        if (delta != null) {
          gettingContextSubMenu(details, delta);
        } else
          return;

        setState(() {
          _count = _count + delta;
        });
      });
    }
  }

  Future<void> gettingContextSubMenu(
      DataGridCellLongPressDetails details, int select) async {
    var position = details.globalPosition;
    var _count = 0;

    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    showMenu(
            context: context,
            items: select == 1
                ? <PopupMenuEntry<int>>[ContextSubMenuAction()]
                : <PopupMenuEntry<int>>[ContextSubMenuAction1()],
            position: RelativeRect.fromRect(
                position & const Size(240, 240), // smaller rect, the touch area
                Offset.zero & overlay.size // Bigger rect, the entire screen
                ))
        // This is how you handle user selection
        .then<void>((int delta) {
      // delta would be null if user taps on outside the popup menu
      // (causing it to close without making selection)
      if (delta == null) return;
      setState(() {
        _count = _count + delta;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
