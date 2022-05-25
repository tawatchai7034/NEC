
import 'dart:convert';

import 'package:nec/api/proxy/apiproxy.dart';
import 'package:nec/api/request/locationToReq.dart';
import 'package:nec/api/response/lacationToRes.dart';

class LocationToAplProxy extends ApiProxy{
  Future<lacationToResp> getLocationTo(String locationTo)async{
   
    lacationToReq req = lacationToReq(locationTo: locationTo);
   
    print('Request to api/ChangeLocation/CheckLocationTo');
    String? result;
    result =
        await processPostRequest('api/ChangeLocation/CheckLocationTo', jsonEncode(req.toJson()));

    lacationToResp resp = lacationToResp.fromJson(jsonDecode(result));
    print('API Response : ' + result);


    return resp;

  }
}