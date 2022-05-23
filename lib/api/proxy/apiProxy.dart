import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiProxy {
  String host = 'http://172.28.19.60:8088/CMKWebService/';

  String dbHost = '172.28.19.51';
  int dbPort = 1521;
  String dbName = 'CMK';
  String dbUser = 'IFSAPP';
  String dbPass = 'ifsapp';

  ApiProxy(
      {this.host = 'http://172.28.19.60:8088/CMKWebService/',
      this.dbHost = '172.28.19.51',
      this.dbPort = 1521,
      this.dbName = 'CMK',
      this.dbUser = 'IFSAPP',
      this.dbPass = 'ifsapp'});

  Future<String> processPostRequest(String url, String body) async {
    var reqUrl = Uri.parse(host + url);
    print('Request Url : ' + reqUrl.toString());
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'DATABASE_HOST': dbHost,
      'DATABASE_PORT': dbPort.toString(),
      'DATABASE_SERVICE_NAME': dbName,
      'DATABASE_USER_NAME': dbUser,
      'DATABASE_PASSWORD': dbPass
    };

    debugPrint('Request Header : ' + headers.toString());
    logPrint('Request Body : ' + body);
    var resp = await http.post(reqUrl, headers: headers, body: body);
    debugPrint('Response Code : ' + resp.statusCode.toString());
    if (resp.statusCode == 200) {
      return resp.body;
    } else {
      throw Exception('API Request error.');
    }
  }

  Future<String> processGetRequest(String url) async {
    var reqUrl = Uri.parse(host + url);
    var resp = await http.get(reqUrl, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'DATABASE_HOST': dbHost,
      'DATABASE_PORT': dbPort.toString(),
      'DATABASE_SERVICE_NAME': dbName,
      'DATABASE_USER_NAME': dbUser,
      'DATABASE_PASSWORD': dbPass
    });
    if (resp.statusCode == 200) {
      return resp.body;
    } else {
      print(resp.body);
      throw Exception('API Request error.');
    }
  }

  void logPrint(Object object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }
}
