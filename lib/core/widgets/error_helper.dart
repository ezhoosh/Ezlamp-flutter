import 'package:dio/dio.dart';
import 'package:easy_lamp/core/resource/base_status.dart';

class ErrorHelper {
  static String getCatchError(DioError error) {
    return error.response == null
        ? "ERROR"
        : error.response!.statusCode.toString();
  }

  static String getError(Response error) {
    return error.statusCode.toString();
  }

  static String getBaseError(BaseStatus error) {
    String errorStr = (error as BaseError).error ?? '';
    return 'ERROR $errorStr';
  }
}
