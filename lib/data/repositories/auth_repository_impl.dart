import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/params/send_phone_number_params.dart';
import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/data/model/send_number_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  Dio dio;
  AuthRepositoryImpl(this.dio);

  @override
  Future<DataState<SendNumberModel>> sendPhoneNumber(
      SendPhoneNumberParams params) async {
    var response = await dio.post("${Constants.baseUrl}is-user-exists/",
        data: {"phone_number": params.number});
    if (response.statusCode == 200) {
      return DataSuccess<SendNumberModel>(
          SendNumberModel.fromJson(jsonDecode(response.data)));
    } else {
      return DataFailed(response.statusMessage.toString());
    }
  }

  @override
  Future<DataState<LoginModel>> login(LoginParams params) async {
    var response = await dio.post("${Constants.baseUrl}login/", data: {
      "phone_number": params.number,
      "password": params.password,
      "sms_token": params.smsToken,
    });
    if (response.statusCode == 200) {
      return DataSuccess<LoginModel>(
          LoginModel.fromJson(jsonDecode(response.data)));
    } else {
      return DataFailed(response.statusMessage.toString());
    }
  }

  @override
  Future<DataState<LoginModel>> register(LoginParams params) async {
    var response = await dio.post("${Constants.baseUrl}register/", data: {
      "phone_number": params.number,
      "password": params.password,
      "sms_token": params.smsToken,
    });
    if (response.statusCode == 200) {
      return DataSuccess<LoginModel>(
          LoginModel.fromJson(jsonDecode(response.data)));
    } else {
      return DataFailed(response.statusMessage.toString());
    }
  }

  @override
  Future<DataState<ResetPasswordModel>> resetPassword(
      LoginParams params) async {
    var response = await dio.post("${Constants.baseUrl}reset-password/", data: {
      "phone_number": params.number,
      "password": params.password,
      "sms_token": params.smsToken,
    });
    if (response.statusCode == 200) {
      return DataSuccess<ResetPasswordModel>(
          ResetPasswordModel.fromJson(jsonDecode(response.data)));
    } else {
      return DataFailed(response.statusMessage.toString());
    }
  }
}
