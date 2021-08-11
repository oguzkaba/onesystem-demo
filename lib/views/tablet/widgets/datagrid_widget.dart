import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/models/exporter_model.dart';
import 'package:onesystem/models/globals_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class DataGridWidget extends StatefulWidget {
  final String title;
  final bool openDialog;
  final DataGridSource dataSource;
  final Function tapFunc, doubleTapFunc, longPressFunc;
  final double height;
  final List<String> colName;
  final DataGridController controller;
  // final bool visible;

  const DataGridWidget(
      {Key key,
      this.controller,
      this.title,
      this.openDialog,
      this.dataSource,
      this.tapFunc,
      this.doubleTapFunc,
      this.longPressFunc,
      this.height,
      this.colName})
      : super(key: key);

  @override
  _DataGridWidgetState createState() => _DataGridWidgetState();
}

class _DataGridWidgetState extends State<DataGridWidget> {
  @override
  void initState() {
    super.initState();
    print('initstate');
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  DataviewController dvc = Get.put(DataviewController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 10,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Global.medium,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3), topRight: Radius.circular(3))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title,
                    style: TextStyle(color: Global.white, fontSize: 14)),
                Row(
                  children: [
                    Obx(() => buildLine()),
                    buildIconButton(),
                  ],
                )
              ],
            ),
            width: double.infinity,
            height: 28,
            padding: EdgeInsets.only(left: 10),
          ),
          Expanded(
            child: Container(
              //height: widget.height == null ? Get.height / 2.50 : widget.height,
              margin: EdgeInsets.all(0),
              child: Obx(() => SfDataGrid(
                    controller: widget.controller,
                    selectionMode: SelectionMode.single,
                    frozenColumnsCount: 1,
                    onCellTap: widget.tapFunc,
                    onCellDoubleTap: widget.doubleTapFunc,
                    onCellLongPress: widget.longPressFunc,
                    headerGridLinesVisibility: dvc.gridState.value
                        ? GridLinesVisibility.horizontal
                        : GridLinesVisibility.both,
                    allowPullToRefresh: true,
                    defaultColumnWidth: 140,
                    source: widget.dataSource,
                    gridLinesVisibility: dvc.gridState.value
                        ? GridLinesVisibility.horizontal
                        : GridLinesVisibility.both,
                    headerRowHeight: 50,
                    rowHeight: 40,
                    columns: <GridColumn>[
                      for (var j = 0; j < widget.colName.length; j++)
                        GridColumn(
                            //columnWidthMode: ColumnWidthMode.fitByCellValue,
                            //width: 150,
                            columnName: widget.colName[j],
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(widget.colName[j]))),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  IconButton buildIconButton() {
    return IconButton(
        onPressed: () => widget.openDialog
            ? Get.back()
            : Get.dialog(AlertDialog(
                content: Container(
                    width: Get.width,
                    height: Get.height,
                    child: DataGridWidget(
                      tapFunc: widget.tapFunc,
                      colName: widget.colName,
                      height: Get.height - 150,
                      title: widget.title,
                      openDialog: true,
                      dataSource: widget.dataSource,
                    )),
              )),
        icon: widget.openDialog
            ? Icon(Icons.close, size: 14, color: Global.white)
            : Icon(Icons.open_in_full, size: 14, color: Global.white));
  }

  IconButton buildLine() {
    return IconButton(
        onPressed: () => dvc.gridState.value = !dvc.gridState.value,
        icon: dvc.gridState.value
            ? Icon(Icons.grid_3x3, size: 14, color: Global.white)
            : Icon(Icons.horizontal_split, size: 14, color: Global.white));
  }
}
