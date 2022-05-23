import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:nec/Screens/transferConfirm.dart';
import 'package:nec/model/User.dart';
import 'package:nec/model/transfer.dart';
import 'package:nec/model/trasferList.dart';

TransferList transfer = new TransferList();

class ChangeLocation extends StatefulWidget {
  final UserModel user;
  const ChangeLocation({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChangeLocation> createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  var numFormat = NumberFormat('#,###', 'en_US');
  var vender = TextEditingController();
  var partNo = TextEditingController();
  var desc = TextEditingController();
  var localDes = TextEditingController();
  var qtyMove = TextEditingController();

  int available = 0;

  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  List<String> virtualLocF = ["a", 'b', 'c', 'd', 'e'];
  List<String> virtualLocT = ["f", 'g', 'h', 'i', 'j'];
  List<String> virtualLot = ["10", "20", "30", "40", "50"];
  List<String> virtualVender = ["10", "20", "30", "40", "50"];
  List<String> virtualPartNo = ["10", "20", "30", "40", "50"];
  String locationDesc = '';
  late bool defaultPartNo;

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

  void _showQtyErr() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Qty Move Error'),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 24),
              child: Text(
                  'Please check, Qty Move is greater then 0 and less than Qty Available.'),
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

  // Initial Selected Value
  String locFron = 'Select';

  // List of items in our dropdown menu
  var Locitems = [
    'Select',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defaultPartNo = widget.user.partNo;
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("Transfer Material"),
      //   backgroundColor: Colors.red,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TitleName(),
            _PartField(widthScreen),
            _BarcodeField(widthScreen),
            _LocationField(widthScreen),
            _Footter(widthScreen),
          ],
        )),
      ),
    );
  }

  Widget _TitleName() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
        child: Container(
          alignment: Alignment.topLeft,
          child: Text('Change Location Material',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ));
  }

  Widget _PartField(double widthScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              widget.user.partNo = !widget.user.partNo;
            });
          },
          child: Container(
            width: widthScreen * 0.4,
            height: 48,
            child: Row(
              children: [
                widget.user.partNo == true
                    ? Icon(Icons.circle_sharp, color: Colors.green)
                    : Icon(Icons.circle_outlined),
                SizedBox(width: 8),
                Text("Part No")
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              widget.user.partNo = !widget.user.partNo;
            });
          },
          child: Container(
            width: widthScreen * 0.4,
            height: 48,
            child: Row(
              children: [
                widget.user.partNo == false
                    ? Icon(Icons.circle_sharp, color: Colors.green)
                    : Icon(Icons.circle_outlined),
                SizedBox(width: 8),
                Text("Lot No")
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _BarcodeField(double widthScreen) {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(4),
      },
      children: [
        TableRow(children: [
          Container(
              margin: const EdgeInsets.all(8.0),
              width: widthScreen * 0.1,
              height: 48,
              child: Center(child: Text("Barcode :"))),
          // ***********************************************************************
          Container(
            margin: const EdgeInsets.all(8.0),
            width: widthScreen * 0.65,
            height: 48,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: TextField(
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                // keyboardType: TextInputType.number,
                controller: vender,
                onSubmitted: (loc) {
                  if (virtualLot.contains(loc)) {
                    // print("Vender id: $loc");
                    if (loc == '10') {
                      partNo.text = '10';
                      setState(() {
                        locationDesc = 'AAAAAAAAAAAAAAA';
                        locFron = 'Select';
                        Locitems.clear();
                        Locitems.add('Select');
                        Locitems.add('Aot1');
                        Locitems.add('Aot2');
                        Locitems.add('Aot3');
                        Locitems.add('Aot4');
                      });
                    } else if (loc == '20') {
                      partNo.text = '20';
                      setState(() {
                        locationDesc = 'BBBBBBBBBBBBBBBBBBBBBB';
                        locFron = 'Select';
                        Locitems.clear();
                        Locitems.add('Select');
                        Locitems.add('Bot1');
                        Locitems.add('Bot2');
                      });
                    } else if (loc == '30') {
                      partNo.text = '30';
                      setState(() {
                        locationDesc = 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC';
                        locFron = 'Select';
                        Locitems.clear();
                        Locitems.add('Select');
                        Locitems.add('Cot1');
                        Locitems.add('Cot2');
                        Locitems.add('Cot3');
                      });
                    } else if (loc == '40') {
                      partNo.text = '40';
                      setState(() {
                        locationDesc =
                            'DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD';
                        locFron = 'Select';
                        Locitems.clear();
                        Locitems.add('Select');
                        Locitems.add('Dot1');
                      });
                    } else if (loc == '50') {
                      partNo.text = '50';
                      setState(() {
                        locationDesc =
                            'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE';
                        locFron = 'Select';
                        Locitems.clear();
                        Locitems.add('Select');
                        Locitems.add('Eot1');
                        Locitems.add('Eot2');
                        Locitems.add('Eot3');
                        Locitems.add('Eot4');
                      });
                    }
                  } else {
                    _showIdNotFound();
                  }
                },
              ),
            ),
          ),
        ]),
        TableRow(children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(8.0),
              width: widthScreen * 0.1,
              height: 48,
              child: Center(child: Text("Part No :"))),
          // ***********************************************************************
          Container(
            margin: const EdgeInsets.all(8.0),
            width: widthScreen * 0.65,
            height: 48,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: TextField(
                enabled: false,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,

                // keyboardType: TextInputType.number,
                controller: partNo,
              ),
            ),
          ),
        ]),
        TableRow(children: [
          Container(
              margin: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              width: widthScreen * 0.1,
              height: 48,
              child: Center(child: Text("    Desc :"))),
          // ***********************************************************************
          (locationDesc == null || locationDesc == '')
              ? Container(
                  margin: const EdgeInsets.all(8.0),
                  width: widthScreen * 0.65,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.black)))
              : Container(
                  margin: const EdgeInsets.all(8.0),
                  width: widthScreen * 0.65,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      locationDesc,
                      style: TextStyle(fontSize: 14),
                      minFontSize: 12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
        ]),
      ],
    );
  }

  Widget _LocationField(double widthScreen) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        children: [
          TableRow(children: [
            Container(
              // margin: const EdgeInsets.all(8.0),
              width: widthScreen * 0.28,
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text("Location From"),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(8.0),
              width: widthScreen * 0.22,
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text("Qty\nAvailable"),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(8.0),
              width: widthScreen * 0.22,
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text("Location To"),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(8.0),
              width: widthScreen * 0.22,
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text("Qty Move"),
              ),
            ),
          ]),
          TableRow(children: [
            Container(
              width: widthScreen * 0.28,
              height: 64,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                width: widthScreen * 0.2,
                height: 24,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: DropdownButton(
                  underline: Text(''),
                  value: locFron,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: Locitems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      locFron = newValue!;

                      if (newValue == 'Aot1') {
                        available = 125;
                      } else if (newValue == 'Aot2') {
                        available = 3;
                      } else if (newValue == 'Aot3') {
                        available = 545;
                      } else if (newValue == 'Aot4') {
                        available = 32456;
                      } else if (newValue == 'Bot1') {
                        available = 36;
                      } else if (newValue == 'Bot2') {
                        available = 6897;
                      } else if (newValue == 'Cot1') {
                        available = 65847;
                      } else if (newValue == 'Cot2') {
                        available = 2;
                      } else if (newValue == 'Cot3') {
                        available = 5;
                      } else if (newValue == 'Dot1') {
                        available = 554;
                      } else if (newValue == 'Eot1') {
                        available = 1;
                      } else if (newValue == 'Eot2') {
                        available = 698;
                      } else if (newValue == 'Eot3') {
                        available = 23;
                      } else if (newValue == 'Eot4') {
                        available = 84;
                      } else {
                        available = 0;
                      }
                    });
                  },
                ),
              ),
            ),
            Container(
              width: widthScreen * 0.28,
              height: 64,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: widthScreen * 0.25,
                  height: 28,
                  child: Center(child: Text(numFormat.format(available)))),
            ),
            Container(
              width: widthScreen * 0.28,
              height: 64,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                width: widthScreen * 0.25,
                height: 28,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.next,
                    // keyboardType: TextInputType.number,
                    controller: localDes,
                    onSubmitted: (loc) {
                      if (virtualLocT.contains(loc)) {
                        print("Vender id: $loc");
                      } else {
                        _showIdNotFound();
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              width: widthScreen * 0.28,
              height: 64,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                width: widthScreen * 0.25,
                height: 28,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    // textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: qtyMove,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onSubmitted: (loc) {
                      int qty = int.parse(loc);
                      if ((qty > 0) && qty <= available) {
                        print("Qty Move: $loc");
                      } else {
                        _showQtyErr();
                      }
                    },
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _Footter(double widthScreen) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(children: <Widget>[
        Positioned(
          // bottom: MediaQuery.of(context).viewInsets.bottom,
          // left: 0,
          // right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // color: Colors.white,
              width: double.infinity,
              height: 96,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 48),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          vender.clear();
                          partNo.clear();
                          desc.clear();
                          localDes.clear();
                          qtyMove.clear();
                          locationDesc = '';
                          available = 0;
                          locFron = 'Select';
                          Locitems.clear();
                          Locitems.add('Select');
                          widget.user.partNo = defaultPartNo;
                        });
                      },
                      child: Container(
                        // margin: const EdgeInsets.all(8.0),
                        width: widthScreen * 0.22,
                        height: 48,
                        decoration: BoxDecoration(
                            color: Colors.red.shade200,
                            border: Border.all(color: Colors.black)),
                        child: Center(child: Text("Clear")),
                      ),
                    ),
                    SizedBox(width: widthScreen * 0.1),
                    InkWell(
                      onTap: () {
                        // Save data and reset
                        setState(() {
                          vender.clear();
                          partNo.clear();
                          desc.clear();
                          localDes.clear();
                          locationDesc = '';
                          qtyMove.clear();
                          available = 0;
                          locFron = 'Select';
                          Locitems.clear();
                          Locitems.add('Select');
                          widget.user.partNo = defaultPartNo;
                        });
                      },
                      child: Container(
                        // margin: const EdgeInsets.all(8.0),
                        width: widthScreen * 0.22,
                        height: 48,
                        decoration: BoxDecoration(
                            color: Colors.green.shade300,
                            border: Border.all(color: Colors.black)),
                        child: Center(child: Text("Confirm")),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
