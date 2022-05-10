import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nec/model/sheets.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final List<SheetModel> _employees = [
  SheetModel(
      PartNo: "1010001\nCCL NPG",
      LocF: 'James',
      LocT: 'Designer',
      Qty: 3215648),
  SheetModel(
      PartNo: "1010001\nCCL NPG",
      LocF: 'Kathryn',
      LocT: 'Project Lead',
      Qty: 5446589),
  SheetModel(
      PartNo: "1010001\nCCL NPG", LocF: 'James', LocT: 'Designer', Qty: 10000),
  SheetModel(
      PartNo: "1010001\nCCL NPG",
      LocF: 'James',
      LocT: 'Developer',
      Qty: 234564),
  SheetModel(
      PartNo: "1010001\nCCL NPG",
      LocF: 'Michael',
      LocT: 'Project Lead',
      Qty: 5448),
  SheetModel(
      PartNo: "1010001\nCCL NPG", LocF: 'Gable', LocT: 'Developer', Qty: 10000),
];
final EmployeeDataSource _employeeDataSource = EmployeeDataSource();
var numFormat = NumberFormat('#,###.0#', 'en_US');

class TableComfirm extends StatefulWidget {
  const TableComfirm({Key? key}) : super(key: key);

  @override
  State<TableComfirm> createState() => _TableComfirmState();
}

class _TableComfirmState extends State<TableComfirm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
        source: _employeeDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(columnName: 'Part No\nDesc', label: Text('Part No\nDesc')),
          GridColumn(
              columnName: 'LocF',
              label: Text(
                'LocF',
              )),
          GridColumn(columnName: 'LocT', label: Text('LocT')),
          GridColumn(
              columnName: 'Qty',
              label: Text(
                'Qty',
                textAlign: TextAlign.center,
              )),
        ]);
  }
}

class EmployeeDataSource extends DataGridSource {
  @override
  List<DataGridRow> get rows => _employees
      .map<DataGridRow>((dataRow) => DataGridRow(cells: [
            DataGridCell<String>(
                columnName: 'Part No\nDesc', value: dataRow.PartNo),
            DataGridCell<String>(columnName: 'LocF', value: dataRow.LocF),
            DataGridCell<String>(columnName: 'LocT', value: dataRow.LocT),
            DataGridCell<String>(
                columnName: 'Qty', value: "${numFormat.format(dataRow.Qty)}"),
          ]))
      .toList();

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      TextAlign? setTextAlign() {
        if (dataGridCell.columnName == 'Qty') {
          return TextAlign.right;
        } else if (dataGridCell.columnName == 'Part No\nDesc') {
          return TextAlign.left;
        } else if (dataGridCell.columnName == 'LocF') {
          return TextAlign.left;
        }else if (dataGridCell.columnName == 'LocT') {
          return TextAlign.left;
        }else {
          return null;
        }
      }

      return Container(
          // alignment: Alignment.topRight,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            dataGridCell.value.toString(),
            // style: getTextStyle(),
            textAlign: setTextAlign(),
            // overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
