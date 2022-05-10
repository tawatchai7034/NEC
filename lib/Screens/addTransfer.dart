import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nec/model/transfer.dart';
import 'package:nec/model/trasferList.dart';
import 'package:nec/Screens/transferConfirm.dart';

TransferList transfer = new TransferList();
var numFormat = NumberFormat('#,###.0#', 'en_US');

class AddTransfer extends StatefulWidget {
  const AddTransfer({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTransfer> createState() => _AddTransferState();
}

class _AddTransferState extends State<AddTransfer> {
  var localStart = TextEditingController();
  var localDes = TextEditingController();
  var lot = TextEditingController();
  var vender = TextEditingController();
  var partNo = TextEditingController();
  var desc = TextEditingController();
  var qty = TextEditingController();
  var count = TextEditingController();
  FocusNode nodePartNo = FocusNode();
  FocusNode nodeQty = FocusNode();

  List<TransferModal> transList = [];
  double totalQty = 0.0;
  int counter = 0;
  int keyCounter = 0;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  List<String> virtualLocF = ["a", 'b', 'c', 'd', 'e'];
  List<String> virtualLocT = ["f", 'g', 'h', 'i', 'j'];
  List<String> virtualLot = ["10", "20", "30", "40", "50"];
  List<String> virtualVender = ["10", "20", "30", "40", "50"];
  List<String> virtualPartNo = ["10", "20", "30", "40", "50"];
  String locationDesc = '';

  void _showNotFoundLocation() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Location not found.'),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 24),
              child: Text('Please enter location again.'),
            ),
            actions: <Widget>[
              // TextButton(
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //     child: Text('Close')),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          );
        });
  }

  void _showIdNotFound() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('ID not found.'),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 24),
              child: Text('Please enter scan again.'),
            ),
            actions: <Widget>[
              // TextButton(
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //     child: Text('Close')),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          );
        });
  }

// reference: https://api.flutter.dev/flutter/services/LogicalKeyboardKey-class.html
  void _handleKeyEvent(RawKeyEvent event) {
    if (keyCounter % 2 == 0) {
      int EscId = 4294967323;
      int EnterId = 4294967309;
      int BackspaceId = 4294967304;
      int SpaceId = 32;

      // print(
      //     "keyId: ${event.logicalKey.keyId} KeyName: ${event.logicalKey.debugName}");

      keyCounter = 0;

      if (event.logicalKey.keyId == BackspaceId) {
        setState(() {
          counter++;
          // totalQty += double.parse(qty.text);
          transfer.addTransfer(TransferModal(
              locF: localStart.text,
              locT: localDes.text,
              lot: lot.text,
              vender: vender.text,
              partNo: int.parse(partNo.text),
              desc: desc.text,
              qty: double.parse(qty.text),
              count: counter,
              amountQty: totalQty));
          totalQty = transfer.getSumQty();
        });

        transfer.ptrTransferList();

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TransferConfirm()));
      } else if (event.logicalKey.keyId == 51) {
        setState(() {
          counter++;
          // totalQty += double.parse(qty.text);
          transfer.addTransfer(TransferModal(
              locF: localStart.text,
              locT: localDes.text,
              lot: lot.text,
              vender: vender.text,
              partNo: int.parse(partNo.text),
              desc: desc.text,
              qty: double.parse(qty.text),
              count: counter,
              amountQty: totalQty));
          partNo.clear();
          desc.clear();
          qty.clear();
          // sumQty.clear();
          count.clear();
          totalQty = transfer.getSumQty();
          locationDesc = '';
        });
        FocusScope.of(context).requestFocus(nodePartNo);
      }
    }
    keyCounter++;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalQty = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Transfer Material"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Text("Location From"),
                  ),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      controller: localStart,
                      onSubmitted: (loc) {
                        if (virtualLocF.contains(loc)) {
                          print("Location from: $loc");
                        } else {
                          _showNotFoundLocation();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Text("to"),
                  ),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      controller: localDes,
                      onSubmitted: (loc) {
                        if (virtualLocT.contains(loc)) {
                          print("Location to: $loc");
                        } else {
                          _showNotFoundLocation();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Text("Barcode LOT"),
                  ),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      // keyboardType: TextInputType.number,
                      controller: lot,
                      onSubmitted: (loc) {
                        if (virtualLot.contains(loc)) {
                          print("LOT id: $loc");
                        } else {
                          _showIdNotFound();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Text("Barcode Vendor"),
                  ),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      // keyboardType: TextInputType.number,
                      controller: vender,
                      onSubmitted: (loc) {
                        if (virtualLot.contains(loc)) {
                          print("Vender id: $loc");
                        } else {
                          _showIdNotFound();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),

            // ----------------------------------------------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Text("Part No :"),
                  ),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      focusNode: nodePartNo,
                      // keyboardType: TextInputType.number,
                      controller: partNo,
                      onSubmitted: (loc) {
                        if (virtualPartNo.contains(loc)) {
                          print("Part No: $loc");

                          if (loc == "10") {
                            locationDesc = 'AAAAAAAAAAAAAAA';
                          } else if (loc == "20") {
                            locationDesc = 'BBBBBBBBBBBBBBBBBBBBBB';
                          } else if (loc == "30") {
                            locationDesc = 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC';
                          } else if (loc == "40") {
                            locationDesc =
                                'DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD';
                          } else if (loc == "50") {
                            locationDesc =
                                'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE';
                          }
                          FocusScope.of(context).requestFocus(nodeQty);
                        } else {
                          _showIdNotFound();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Text(
                      "Desc :",
                      // style: TextStyle(fontSize: 14),
                    ),
                  ),
                  (locationDesc == null || locationDesc == '')
                      ? Container()
                      : Container(
                          width: widthScreen * 0.75,
                          child: AutoSizeText(
                            locationDesc,
                            style: TextStyle(fontSize: 14),
                            minFontSize: 12,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                  // Expanded(
                  //   child: TextField(
                  //     textInputAction: TextInputAction.next,
                  //     enabled: false,
                  //     controller: desc,
                  //     onSubmitted: (loc) {},
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                      child: Text("Qty :"),
                    ),
                    Expanded(
                      child: RawKeyboardListener(
                        focusNode: focusNode,
                        onKey: _handleKeyEvent,
                        child: TextField(
                          focusNode: nodeQty,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          controller: qty,
                          onSubmitted: (loc) {
                            setState(() {
                              totalQty = transfer.getSumQty();
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: totalQty == 0.0
                            ? Container(
                                width: widthScreen * 0.3,
                                child: Text(
                                    "Sum Qty :  ${totalQty.toStringAsFixed(1)}"))
                            : Container(
                                width: widthScreen * 0.3,
                                child: Text(
                                    "Sum Qty :  ${numFormat.format(totalQty)}")))
                  ],
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Text("Count : ${counter}"),
                  ),
                ],
              ),
            ),
          ],
        )),
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
                child: Text("Prees Enter to continue, Esc to confirm"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
