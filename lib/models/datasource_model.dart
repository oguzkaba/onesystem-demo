import 'package:flutter/material.dart';
import 'package:onesystem/controllers/dataview_controller.dart';
import 'package:onesystem/views/tablet/main_page.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeeDataSource extends DataGridSource {
  DataviewController dvc = DataviewController();
  MainPage mp = MainPage();

  /// Creates the employee data source class with required details.
  int _count = 1;
  List<dynamic> _reEmployeData = [];
  EmployeeDataSource(
      {List<dynamic> employeeData, List<dynamic> listForFields, int detail}) {
    print(employeeData.length.toString());
    _count = listForFields.length;
    _reEmployeData = employeeData;
    getEmployees(employeeData, _count);
  }

  void getEmployees(List<dynamic> employeeData, int count) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              //for (var z = 0; z < 3; z++)
              for (var f = 1; f < count; f++)
                DataGridCell(columnName: e[f].toString(), value: e[f]),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

//Refresh Method
  @override
  Future<void> handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    dvc.refreshData.value = true;
    getEmployees(_reEmployeData, _count);
    print('Refreshing...' + _reEmployeData.length.toString());
    notifyListeners();
  }
}
