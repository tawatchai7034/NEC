import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nec/Screens/addTransfer.dart';
import 'package:nec/model/sheets.dart';
import 'package:nec/Screens/tableConfirm.dart';
import 'package:nec/Screens/virtualData.dart';
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
        body: _getBody()
        // Center(
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: TableComfirm(),
        //   ),
        // ),
        // bottomNavigationBar:
        // Container(
        //   // height: 48,
        //   child: Padding(
        //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 48),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [

        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        //           child: Text("Confirm Transfer data y/n?"),
        //         ),
        //         Expanded(
        //           child: TextField(
        //             controller: confirm,
        //             onSubmitted: (con) {
        //               if ((con == "y") || (con == "yes")) {
        //                 Navigator.of(context).pushAndRemoveUntil(
        //                     MaterialPageRoute(
        //                         builder: (context) => AddTransfer()),
        //                     (route) => false);
        //               }
        //               confirm.clear();
        //             },
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }

  Widget _getBody() {
    return Stack(children: <Widget>[
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TableComfirm(),
        ),
      ),
      Positioned(
        // bottom: MediaQuery.of(context).viewInsets.bottom,
        // left: 0,
        // right: 0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 48),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
        ),
      ),
    ]);
  }

  //  Widget _getBody() {
  //   return Stack(children: <Widget>[
  //     Container(
  //       // decoration: BoxDecoration(
  //       //     image: DecorationImage(
  //       //         image: AssetImage("assets/sample.jpg"), fit: BoxFit.fitWidth)),
  //       // color: Color.fromARGB(50, 200, 50, 20),
  //       child: Column(
  //         children: <Widget>[TextField()],
  //       ),
  //     ),
  //     Positioned.fill(
  //       // bottom: MediaQuery.of(context).viewInsets.bottom,
  //       // left: 0,
  //       // right: 0,
  //       child: Align(
  //         alignment: Alignment.bottomCenter,
  //         child: Container(
  //           height: 50,
  //           width: 360,
  //           child: Text("Aboveeeeee"),
  //           decoration: BoxDecoration(color: Colors.pink),
  //         ),
  //       ),
  //     ),
  //   ]);
  // }
}
