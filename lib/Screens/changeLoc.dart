import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import 'package:nec/Screens/transferConfirm.dart';
import 'package:nec/api/proxy/barcodeApiProxy.dart';
import 'package:nec/api/proxy/changeLocApiProxy.dart';
import 'package:nec/api/proxy/locationToApiProxy.dart';
import 'package:nec/api/proxy/qtyMoveApiProxy.dart';
import 'package:nec/api/response/barcodeRes.dart';
import 'package:nec/api/response/changeLocResp.dart';
import 'package:nec/api/response/lacationToRes.dart';
import 'package:nec/api/response/loginRes.dart';
import 'package:nec/api/response/qtyMoveResp.dart';
import 'package:nec/model/User.dart';
import 'package:nec/model/transfer.dart';
import 'package:nec/model/trasferList.dart';

TransferList transfer = new TransferList();

class ChangeLocation extends StatefulWidget {
  final LoginResponse changeLocation;
  const ChangeLocation({
    Key? key,
    required this.changeLocation,
  }) : super(key: key);

  @override
  State<ChangeLocation> createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  var numFormat = NumberFormat('#,###.0#', 'en_US');
  var barcode = TextEditingController();
  var partNo = TextEditingController();
  var desc = TextEditingController();
  var locTo = TextEditingController();
  var qtyMove = TextEditingController();

  double qty_available = 0.0;
  double qty_move = 0.0;
  List<BarcodeDataRes> bacodeList = [];

  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  String locationDesc = '';
  late bool defaultPartNo;
  String? messageWarning = "";
  late String barCodeNumber;
  late String locationTo;

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
    widget.changeLocation.defaultOption == "PART_NO"
        ? defaultPartNo = true
        : defaultPartNo = false;
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
              defaultPartNo = !defaultPartNo;
              widget.changeLocation.defaultOption = "PART_NO";
            });
          },
          child: Container(
            width: widthScreen * 0.4,
            height: 48,
            child: Row(
              children: [
                defaultPartNo == true
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
              defaultPartNo = !defaultPartNo;
              widget.changeLocation.defaultOption = "LOT_NO";
            });
          },
          child: Container(
            width: widthScreen * 0.4,
            height: 48,
            child: Row(
              children: [
                defaultPartNo == false
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
                controller: barcode,
                onSubmitted: (loc) {
                  doBarcode();
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
        columnWidths: {
          0: FlexColumnWidth(1.5),
          1: FlexColumnWidth(1.1),
          2: FlexColumnWidth(1.2),
          3: FlexColumnWidth(1.2),
        },
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
              width: widthScreen * 0.20,
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
                    BarcodeDataRes barcodeData = bacodeList.singleWhere(
                        (barcodeList) => (barcodeList.locationFrom == newValue),
                        orElse: () => BarcodeDataRes(errorMessage: '404'));

                    if (barcodeData.errorMessage != '404') {
                      // print('++++++++++++++++++++++ ${barcodeData.qtyAvailable} ++++++++++++++++++++++');
                      setState(() {
                        // locFron = newValue!;
                        qty_available = barcodeData.qtyAvailable!;
                      });
                    } else {
                      setState(() {
                        // locFron = newValue!;
                        qty_available = 0.0;
                      });
                    }
                    setState(() {
                      locFron = newValue!;
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
                  child: Center(
                      child: qty_available == 0
                          ? Text('0.0')
                          : Text(numFormat.format(qty_available)))),
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
                    controller: locTo,
                    onSubmitted: (loc) {
                      doLocationTo();
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
                      doQtyMove();
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
                        resetAll();
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
                        doChangeLocation();
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

  doBarcode() async {
    // print("doLogin()");
    if (barcode.text.isNotEmpty) {
      try {
        EasyLoading.show(status: 'loading...');
        barCodeNumber = barcode.text;

        BarcodeApiProxy barCodeProxy = BarcodeApiProxy();

        List<BarcodeDataRes> bacodeRes = await barCodeProxy.getBarcodeData(
            barCodeNumber, widget.changeLocation.defaultOption!);
        if (defaultPartNo == true) {
          locFron = 'Select';
          Locitems.clear();
          Locitems.add('Select');
          for (int index = 0; index < bacodeRes.length; index++) {
            partNo.text = bacodeRes[index].partNo!;
            locationDesc = bacodeRes[index].partDesc!;
            Locitems.add(bacodeRes[index].locationFrom!);
            bacodeList.add(bacodeRes[index]);
          }
          EasyLoading.dismiss();
        } else {
          EasyLoading.dismiss();
          return null;
        }

        EasyLoading.dismiss();
      } on SocketException catch (e) {
        EasyLoading.dismiss();
        wrongDialog(e.message);
      } on Exception catch (e) {
        EasyLoading.dismiss();
        wrongDialog(e.toString());
      }
    } else {
      wrongDialog(messageWarning!);
    }
  }

  doLocationTo() async {
    // print("doLogin()");
    if (locTo.text.isNotEmpty) {
      try {
        EasyLoading.show(status: 'loading...');
        locationTo = locTo.text;

        LocationToAplProxy locToProxy = LocationToAplProxy();

        lacationToResp? locationToRes =
            await locToProxy.getLocationTo(locationTo);
        if (locationToRes == null) {
          EasyLoading.dismiss();
          return null;
        } else {
          messageWarning = locationToRes.errorMessage;
          wrongDialog(messageWarning!);
          EasyLoading.dismiss();
        }

        EasyLoading.dismiss();
      } on SocketException catch (e) {
        EasyLoading.dismiss();
        wrongDialog(e.message);
      } on Exception catch (e) {
        EasyLoading.dismiss();
        wrongDialog(e.toString());
      }
    } else {
      wrongDialog(messageWarning!);
    }
  }

  doQtyMove() async {
    // print("doLogin()");
    if (qtyMove.text.isNotEmpty) {
      try {
        EasyLoading.show(status: 'loading...');
        qty_move = double.parse(qtyMove.text);

        qtyMoveApiProxy qtyMoveProxy = qtyMoveApiProxy();

        qtyMoveResp? qtyMoveRes =
            await qtyMoveProxy.getQtyMove(qty_available, qty_move);
        if (qtyMoveRes == null) {
          EasyLoading.dismiss();
          return null;
        } else {
          messageWarning = qtyMoveRes.errorMessage!;
          wrongDialog(messageWarning!);
          EasyLoading.dismiss();
        }

        EasyLoading.dismiss();
      } on SocketException catch (e) {
        EasyLoading.dismiss();
        wrongDialog(e.message);
      } on Exception catch (e) {
        EasyLoading.dismiss();
        wrongDialog(e.toString());
      }
    } else {
      wrongDialog(messageWarning!);
    }
  }

  doChangeLocation() async {
    // print("doLogin()");
    if (barcode.text.isNotEmpty &&
        locTo.text.isNotEmpty &&
        locFron != 'Select' &&
        qtyMove.text.isNotEmpty) {
      try {
        EasyLoading.show(status: 'loading...');
        String? partNumber;
        String? lotNumber;
        locationTo = locTo.text;

        if (defaultPartNo = true) {
          partNumber = partNo.text;
          lotNumber = null;
        } else {
          partNumber = null;
          lotNumber = partNo.text;
        }

        ChangeLocationApiProxy changeLocProxy = ChangeLocationApiProxy();

        ChangeLocationResp? changeLocRes = await changeLocProxy.changeLocation(
          widget.changeLocation.defaultOption!,
          partNumber!,
          lotNumber,
          locFron,
          locationTo,
          qty_move,
        );

        if (changeLocRes == null) {
          EasyLoading.dismiss();
          resetAll();

          return null;
        } else {
          messageWarning = changeLocRes.errorMessage;
          wrongDialog(messageWarning!);
          EasyLoading.dismiss();
        }

        EasyLoading.dismiss();
      } on SocketException catch (e) {
        EasyLoading.dismiss();
        wrongDialog(e.message);
      } on Exception catch (e) {
        EasyLoading.dismiss();
        wrongDialog(e.toString());
      }
    } else {
      wrongDialog(messageWarning!);
    }
  }

  wrongDialog(String msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('Information'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 11.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,
            //color: Colors.amber,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void resetAll() {
    setState(() {
      barcode.clear();
      partNo.clear();
      desc.clear();
      locTo.clear();
      locationDesc = '';
      qtyMove.clear();
      qty_available = 0.0;
      locFron = 'Select';
      Locitems.clear();
      Locitems.add('Select');
      bacodeList.clear();
      widget.changeLocation.defaultOption == "PART_NO"
          ? defaultPartNo = true
          : defaultPartNo = false;
    });
  }
}
