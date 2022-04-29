import 'package:flutter/material.dart';

import 'package:nec/model/transfer.dart';
import 'package:nec/model/trasferList.dart';
import 'package:nec/qrScan.dart';
import 'package:nec/transferConfirm.dart';

TransferList transfer = new TransferList();

class AddTransfer extends StatefulWidget {
  final String test;
  const AddTransfer({
    Key? key,
    required this.test,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // transList = transfer.getTransferList();
    // if(transList != null) {
    lot.text = widget.test;
    vender.text = widget.test;
    partNo.text = widget.test;
    // }
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
                        controller: lot,
                        onChanged: (lot) {},
                        onTap: () {},
                        decoration: InputDecoration(),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => QRScanner(fromMenu: 0)));
                          },
                          icon: Icon(Icons.qr_code)),
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
                        controller: vender,
                        onChanged: (vender) {},
                        onTap: () {},
                        decoration: InputDecoration(),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => QRScanner(fromMenu: 1)));
                          },
                          icon: Icon(Icons.qr_code)),
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
                        controller: partNo,
                        onChanged: (partNo) {},
                        onTap: () {},
                        decoration: InputDecoration(),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => QRScanner(fromMenu: 2)));
                          },
                          icon: Icon(Icons.qr_code)),
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
                        child: TextFormField(
                          // key: Key(totalCalculated()),
                          controller: qty,
                          onChanged: (qty) {},
                          onTap: () {},
                          decoration: InputDecoration(),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 8, 0),
                        child: Text("Sum Qty :"),
                      ),
                      Expanded(
                        child: TextFormField(
                          // key: Key(totalCalculated()),
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
                      child: Text("Count :"),
                    ),
                    Expanded(
                      child: TextFormField(
                        // key: Key(totalCalculated()),
                        controller: count,
                        onChanged: (count) {},
                        onTap: () {},
                        decoration: InputDecoration(),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    ElevatedButton(
                      child: Text('บันทึก'),
                      onPressed: () {
                        transfer.addTransfer(TransferModal(
                            locF: localStart.text,
                            locT: localDes.text,
                            lot: lot.text,
                            vender: vender.text,
                            partNo: int.parse(partNo.text),
                            desc: desc.text,
                            qty: double.parse(qty.text),
                            count: int.parse(count.text),
                            amountQty: double.parse(sumQty.text)));

                        transfer.ptrTransferList();

                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => TransferConfirm()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ));
  }
}
