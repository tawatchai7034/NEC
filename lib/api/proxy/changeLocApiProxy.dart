import 'dart:convert';

import 'package:nec/api/proxy/apiproxy.dart';
import 'package:nec/api/request/changeLocReq.dart';
import 'package:nec/api/response/changeLocResp.dart';

class ChangeLocationApiProxy extends ApiProxy {
  Future<ChangeLocationResp?> changeLocation(
    String defaultOption,
    String partNo,
    String? lotNo,
    String locationFrom,
    String locationTo,
    double qtyMove,
  ) async {
    ChangeLocationReq req = ChangeLocationReq(
        defaultOption: defaultOption,
        partNo: partNo,
        lotNo: lotNo,
        locationFrom: locationFrom,
        locationTo: locationTo,
        qtyMove: qtyMove);

    print('Request to api/ChangeLocation/ChangeLocation');
    String? result;
    result = await processPostRequest(
        'api/ChangeLocation/ChangeLocation', jsonEncode(req.toJson()));

    var isCheck = jsonDecode(result);

    if (isCheck == null) {
      return null;
    } else {
      ChangeLocationResp resp = ChangeLocationResp.fromJson(jsonDecode(result));
      print('API Response : ' + result);

      return resp;
    }
  }
}
