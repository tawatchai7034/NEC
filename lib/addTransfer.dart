import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nec/keyPage.dart';

import 'package:nec/model/transfer.dart';
import 'package:nec/model/trasferList.dart';
import 'package:nec/transferConfirm.dart';

TransferList transfer = new TransferList();

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
  var sumQty = TextEditingController();
  var count = TextEditingController();

  List<TransferModal> transList = [];
  double totalQty = 0;
  int counter = 0;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

// reference: https://api.flutter.dev/flutter/services/LogicalKeyboardKey-class.html
  void _handleKeyEvent(RawKeyEvent event) {
    print(
        "keyId: ${event.logicalKey.keyId} KeyName: ${event.logicalKey.debugName}");
    int EscId = 4294967323;
    int EnterId = 4294967309;
    int BackspaceId = 4294967304;
    int SpaceId = 32;

    if (event.logicalKey.keyId == BackspaceId) {
      setState(() {
        counter++;
        totalQty += double.parse(qty.text);
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
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => TransferConfirm()));
    } else if (event.logicalKey.keyId == 51) {
      setState(() {
        counter++;
        totalQty += double.parse(qty.text);
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
        sumQty.clear();
        count.clear();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sumQty.text = totalQty.toString();
  }

  @override
  Widget build(BuildContext context) {
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
                      child: TextFormField(
                        // key: Key(totalCalculated()),
                        textInputAction: TextInputAction.next,
                        controller: localStart,
                        onChanged: (localStart) {},
                        onTap: () {},
                        decoration: InputDecoration(),
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Text("to"),
                    ),
                    Expanded(
                      child: TextFormField(
                        // key: Key(totalCalculated()),
                        textInputAction: TextInputAction.next,
                        controller: localDes,
                        onChanged: (localDes) {},
                        onTap: () {},
                        decoration: InputDecoration(),
                        // keyboardType: TextInputType.number,
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
                      child: TextFormField(
                        // key: Key(totalCalculated()),
                        textInputAction: TextInputAction.next,
                        controller: lot,
                        onChanged: (lot) {},
                        onTap: () {},
                        decoration: InputDecoration(),
                        keyboardType: TextInputType.number,
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
                      child: TextFormField(
                        // key: Key(totalCalculated()),
                        textInputAction: TextInputAction.next,
                        controller: vender,
                        onChanged: (vender) {},
                        onTap: () {},
                        decoration: InputDecoration(),
                        keyboardType: TextInputType.number,
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
                      child: TextFormField(
                        // key: Key(totalCalculated()),
                        textInputAction: TextInputAction.next,
                        controller: partNo,
                        onChanged: (partNo) {},
                        onTap: () {},
                        decoration: InputDecoration(),
                        keyboardType: TextInputType.number,
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
                      child: Text("Desc :"),
                    ),
                    Expanded(
                      child: TextFormField(
                        // key: Key(totalCalculated()),
                        textInputAction: TextInputAction.next,
                        controller: desc,
                        onChanged: (desc) {},
                        onTap: () {},
                        decoration: InputDecoration(),
                        // keyboardType: TextInputType.number,
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
                        child: Text("Qty :"),
                      ),
                      Expanded(
                        child: RawKeyboardListener(
                          focusNode: focusNode,
                          onKey: _handleKeyEvent,
                          child: TextFormField(
                            // key: Key(totalCalculated()),
                            // textInputAction: TextInputAction.next,
                            controller: qty,

                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 8, 0),
                        child: Text("Sum Qty :"),
                      ),
                      Expanded(
                        child: TextFormField(
                          // key: Key(totalCalculated()),
                          enabled: false,
                          controller: sumQty,
                          onChanged: (sumQty) {},
                          onTap: () {},
                          decoration: InputDecoration(),
                          keyboardType: TextInputType.number,
                        ),
                      ),
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
                      child: Text("Count : ${counter + 1}"),
                    ),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Spacer(),
              //       ElevatedButton(
              //         child: Text('บันทึก'),
              //         onPressed: () {
              //           // transfer.addTransfer(TransferModal(
              //           //     locF: localStart.text,
              //           //     locT: localDes.text,
              //           //     lot: lot.text,
              //           //     vender: vender.text,
              //           //     partNo: int.parse(partNo.text),
              //           //     desc: desc.text,
              //           //     qty: double.parse(qty.text),
              //           //     count: int.parse(count.text),
              //           //     amountQty: double.parse(sumQty.text)));

              //           // transfer.ptrTransferList();

              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) => TransferConfirm()));
              //         },
              //         style: ElevatedButton.styleFrom(
              //             primary: Colors.green,
              //             padding:
              //                 EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              //             textStyle: TextStyle(
              //                 fontSize: 30, fontWeight: FontWeight.bold)),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          )),
        ));
  }
}
