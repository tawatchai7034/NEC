import 'dart:convert';

import 'package:nec/api/proxy/apiproxy.dart';
import 'package:nec/api/request/loginReq.dart';
import 'package:nec/api/response/loginRes.dart';


class LoginApiProxy extends ApiProxy {
  Future<String?> login(String userName, String password) async {
    LoginRequest req = LoginRequest(userName: userName, passWord: password);

    print('Request to api/Common/Login');
    String? result;
    result =
        await processPostRequest('api/Common/Login', jsonEncode(req.toJson()));
    print('API Response : ' + result);
    if (result == "null") {
      return '';
    } else {
      LoginResponse resp = LoginResponse.fromJson(jsonDecode(result));
      return resp.errorMessage;
    }
  }
}
