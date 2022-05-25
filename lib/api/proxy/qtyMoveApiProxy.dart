import 'dart:convert';

import 'package:nec/api/proxy/apiproxy.dart';
import 'package:nec/api/request/qtyMoveReq.dart';
import 'package:nec/api/response/qtyMoveResp.dart';

class qtyMoveApiProxy extends ApiProxy {
  Future<qtyMoveResp?> getQtyMove(double qtyAvailable, double qtyMove) async {
    qtyMoveReq req = qtyMoveReq(qtyAvailable: qtyAvailable, qtyMove: qtyMove);

    print('Request to api/ChangeLocation/CheckQtyMove');
    String? result;
    result = await processPostRequest(
        'api/ChangeLocation/CheckQtyMove', jsonEncode(req.toJson()));

    var isCheck = jsonDecode(result);

    if (isCheck == null) {
      return null;
    } else {
      qtyMoveResp resp = qtyMoveResp.fromJson(jsonDecode(result));
      print('API Response : ' + result);

      return resp;
    }
  }
}
