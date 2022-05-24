import 'dart:convert';

import 'package:nec/api/proxy/apiProxy.dart';
import 'package:nec/api/request/barcodeReq.dart';
import 'package:nec/api/response/barcodeRes.dart';

class BarcodeApiProxy extends ApiProxy {
  Future<List<BarcodeDataRes>> getBarcodeData(
      String barcode, String defaultOption) async {
    BarcodeDataReq req =
        BarcodeDataReq(barcode: barcode, defaultOption: defaultOption);
    print('api/ChangeLocation/GetBarcodeData');
    String? result;
    result = await processPostRequest(
        'api/ChangeLocation/GetBarcodeData', jsonEncode(req.toJson()));

    if (result != "null") {
      List<BarcodeDataRes> returnValue = [];
      List<dynamic> json = jsonDecode(result);
      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(BarcodeDataRes.fromJson(item));
        }
      }

      print('API Response : ' + result);
      // if (result == "null") {
      //   return result;
      // } else {

      //   return resp;
      // }

      return returnValue;
    } else {
      return [];
    }
  }
}
