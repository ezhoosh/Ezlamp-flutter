import 'package:dio/dio.dart';
import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/locator.dart';

class ApiAccess {
  static Future<Response> makeHttpRequest(String url,
      {Map<String, dynamic>? data, String method='POST',}) async {
    Dio dio = locator();
    return await dio.request("${Constants.baseUrl}$url",
        data: data,
        options: Options(
          method: method,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded',
            'Connection': 'keep-alive',
          },
        ));
  }
}
