import 'package:flutter/material.dart';
import 'package:nec/model/sheets.dart';
import 'package:nec/virtualData.dart';
import 'package:nec/widget/scrollable_widget.dart';

class TransferConfirm extends StatefulWidget {
  @override
  _TransferConfirmState createState() => _TransferConfirmState();
}

class _TransferConfirmState extends State<TransferConfirm> {
  late List<SheetModel> users;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();

    this.users = List.of(allSheets);
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    int your_number_of_rows = 4;
    double rowHeight =
        (MediaQuery.of(context).size.height - 56) / your_number_of_rows;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Summary"),
        backgroundColor: Colors.red,
      ),
      body: ScrollableWidget(child: buildDataTable(widthScreen, rowHeight)),
    );
  }

  Widget buildDataTable(double widthScreen, double rowHeight) {
    final columns = ['Part No\nDesc', 'LocF', 'LocT', 'Qty'];

    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      dataRowHeight: rowHeight,
      headingRowHeight: 56.0,
      columns: getColumns(columns),
      rows: getRows(users, widthScreen),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<SheetModel> sheets, double widthScreen) =>
      users.map((SheetModel sheet) {
        final cells = [sheet.PartNo, sheet.LocF, sheet.LocT, sheet.Qty];

        return DataRow(cells: getCells(cells, widthScreen));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells, double widthScreen) => cells
      .map((data) => DataCell(Container(
          width: widthScreen * 0.1,
          // height: widthScreen * 0.5,
          child: Text('$data', textAlign: TextAlign.left))))
      .toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      users.sort((user1, user2) =>
          compareString(ascending, user1.PartNo, user2.PartNo));
    } else if (columnIndex == 1) {
      users.sort(
          (user1, user2) => compareString(ascending, user1.LocF, user2.LocF));
    } else if (columnIndex == 2) {
      users.sort(
          (user1, user2) => compareString(ascending, user1.LocT, user2.LocT));
    } else if (columnIndex == 3) {
      users.sort((user1, user2) =>
          compareString(ascending, '${user1.Qty}', '${user2.Qty}'));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
