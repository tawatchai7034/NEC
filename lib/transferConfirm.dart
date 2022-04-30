import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nec/addTransfer.dart';
import 'package:nec/model/sheets.dart';
import 'package:nec/tableConfirm.dart';
import 'package:nec/virtualData.dart';
import 'package:nec/widget/scrollable_widget.dart';

class TransferConfirm extends StatefulWidget {
  @override
  _TransferConfirmState createState() => _TransferConfirmState();
}

class _TransferConfirmState extends State<TransferConfirm> {
  var confirm = TextEditingController();
  var format = NumberFormat('#,###.0#', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Summary"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TableComfirm(),
        ),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text("Confirm Transfer data y/n?"),
              ),
              Expanded(
                child: TextField(
                  controller: confirm,
                  onSubmitted: (con) {
                    if ((con == "y") || (con == "yes")) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => AddTransfer()),
                          (route) => false);
                    }
                    confirm.clear();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
